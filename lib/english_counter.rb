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
      attr_accessor :current_idiom
      attr_accessor :keep_words

      def push_idiom(word)
        self.current_idiom = keep_words + " " + word
        self.keep_words = nil
      end

      def add_idiom(word)
        self.current_idiom += " " + word
      end

      def pop_idiom
        ret = self.current_idiom
        self.current_idiom = nil
        ret
      end

      def keep(word)
        self.keep_words = word
      end
    end

    def group_idiom_word(words)
      idiom_hash = Hash.new { 0 }
      word_hash = Hash.new { 0 }

      context = GroupingContext.new

      words.each do |word|
        if context.current_idiom
          if word.start_with?(/[A-Z]/) || word == "of"
            context.add_idiom(word)
          else
            idiom_hash[context.pop_idiom] += 1

            word_hash[word] += 1
          end
        else
          if word.start_with?(/[A-Z]/)
            if context.keep_words
              context.push_idiom(word)
            else
              context.keep(word)
            end
          elsif word == "of"
            if context.keep_words
              context.push_idiom(word)
            else
              word_hash[word] += 1
            end
          else
            context.keep_words.split.each { |x| word_hash[x] += 1 } if context.keep_words
            context.keep_words = nil
            word_hash[word] += 1
          end
        end
      end

      return idiom_hash, word_hash
    end

    def hash_to_array(hash)
      hash.to_a.map { |x| [x[1], x[0]]}.sort { |a, b| (b[0] <=> a[0]).nonzero? || (a[1].downcase <=> b[1].downcase) }
    end
end

