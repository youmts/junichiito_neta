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
    def split_words(input)
      input.split(/[\n\s]/)
        .map {|x| x.split(/([“”,.])/)}.flatten # 区切り文字を分割してリスト化する
        .select {|x| !x.strip.empty?}
    end

    class GroupingContext
      def initialize
        @current_words = []
      end

      def keep_word(word)
        @current_words << word
      end

      def end_keep
        ret = @current_words
        @current_words = []
        ret
      end

      def in_keep?
        !@current_words.empty?
      end

      def print_status
        pp @current_words
      end
    end

    def group_idiom_word(words)
      idiom_hash = Hash.new { 0 }
      word_hash = Hash.new { 0 }

      context = GroupingContext.new

      words.each do |word|
        if word.start_with?(/[A-Z]/)
          context.keep_word(word)
        elsif word == "of"
          if context.in_keep?
            context.keep_word(word)
          else
            word_hash[word] += 1
          end
        else
          word_hash[word] += 1

          kept_words = context.end_keep
          if kept_words.size > 1
            idiom_hash[kept_words.join(" ")] += 1
          else
            kept_words.each { |x| word_hash[x] += 1 }
          end
        end
      end

      [idiom_hash, word_hash]
    end

    def make_result(idiom_hash, word_hash)
      result = EnglishCounter::Result.new
      result.idioms = hash_to_array(idiom_hash)
      result.words = hash_to_array(word_hash).select { |x| word?(x[1])}
      result
    end

    def word?(word)
      if %w(– “ ” , .).include?(word)
        false
      else
        true
      end
    end


    # 言葉 => 回数のハッシュを
    # [回数, 言葉]の配列に変換して、
    # 回数の降順 > 言葉の昇順にソートして返す
    def hash_to_array(hash)
      hash.to_a
        .map { |x| [x[1], x[0]]}
        .sort { |a, b| (b[0] <=> a[0]).nonzero? || (a[1].downcase <=> b[1].downcase) }
    end
end

