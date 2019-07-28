require 'pp'

module EnglishCounter
  extend self

  class Result
    attr_accessor :idioms, :words
  end

  def parse(input)
    words = split_words(input)
    idiom_hash, word_hash = group_idiom_word(words)
    make_result(idiom_hash, word_hash)
  end

  private
    def make_result(idiom_hash, word_hash)
      result = EnglishCounter::Result.new
      result.idioms = hash_to_array(idiom_hash)
      result.words = hash_to_array(word_hash).select { |x| word?(x[1])}
      result
    end

    def split_words(input)
      input.split(/[\n\s]/)
        .map {|x| custom_split(x)}.flatten
        .select {|x| !x.strip.empty?}

    end

    def custom_split(word)
      word.split(/([“”,.])/)
    end

    def word?(word)
      if %w(– “ ” , .).include?(word)
        false
      else
        true
      end
    end

    class GroupingContext
      def initialize
        @current_idiom = nil
        @keep_words = []
      end

      def start_idiom(word)
        @current_idiom = [@keep_words + [word]]
        @keep_words = []
      end

      def add_idiom(word)
        @current_idiom << word
      end

      def end_idiom
        ret = @current_idiom
        @current_idiom = nil
        ret
      end

      def in_idiom?
        !!@current_idiom
      end

      def add_keep(word)
        @keep_words << word
      end

      def end_keep
        ret = @keep_words.clone
        @keep_words = []
        ret
      end

      def keeping?
        !@keep_words.empty?
      end
    end

    def group_idiom_word(words)
      idiom_hash = Hash.new { 0 }
      word_hash = Hash.new { 0 }

      context = GroupingContext.new

      words.each do |word|
        if context.in_idiom?
          if word.start_with?(/[A-Z]/) || word == "of"
            context.add_idiom(word)
          else
            idiom_hash[context.end_idiom.join(" ")] += 1

            word_hash[word] += 1
          end
        else
          if word.start_with?(/[A-Z]/)
            if context.keeping?
              context.start_idiom(word)
            else
              context.add_keep(word)
            end
          elsif word == "of"
            if context.keeping?
              context.start_idiom(word)
            else
              word_hash[word] += 1
            end
          else
            context.end_keep.each { |x| word_hash[x] += 1 }
            word_hash[word] += 1
          end
        end
      end

      [idiom_hash, word_hash]
    end

    def hash_to_array(hash)
      hash.to_a.map { |x| [x[1], x[0]]}.sort { |a, b| (b[0] <=> a[0]).nonzero? || (a[1].downcase <=> b[1].downcase) }
    end
end

