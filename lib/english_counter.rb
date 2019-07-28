require 'pp'

module EnglishCounter
  extend self

  def parse(input)
    words = input.split(/[\n\s]/)
      .map { |x| custom_split(x) }.flatten
      .select { |x| !x.strip.empty? }

    p words

    result = generate_result(words)
  end

  private
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

    def generate_result(words)
      idiom_hash = Hash.new { 0 }
      word_hash = Hash.new { 0 }

      current_idiom = nil
      keep_words = nil
      words.each do |word|
        p "#{current_idiom}, #{keep_words}"
        if current_idiom
          if word.start_with?(/[A-Z]/) || word == "of"
            current_idiom += " " + word
          else
            idiom_hash[current_idiom] += 1
            current_idiom = nil

            word_hash[word] += 1
          end
        else
          if word.start_with?(/[A-Z]/)
            if keep_words
              current_idiom = keep_words + " " + word
              keep_words = nil
            else
              keep_words = word
            end
          elsif word == "of"
            if keep_words
              current_idiom = keep_words + " " + word
              keep_words = nil
            else
              word_hash[word] += 1
            end
          else
            keep_words.split.each { |x| word_hash[x] += 1 } if keep_words
            keep_words = nil
            word_hash[word] += 1
          end
        end
      end

      result = EnglishCounter::Result.new
      result.idioms = hash_to_array(idiom_hash)
      result.words = hash_to_array(word_hash).select { |x| word?(x[1])}
      pp result.idioms
      pp result.words
      result
    end

    def hash_to_array(hash)
      hash.to_a.map { |x| [x[1], x[0]]}.sort { |a, b| (b[0] <=> a[0]).nonzero? || (a[1].downcase <=> b[1].downcase) }
    end
end

class EnglishCounter::Result
  attr_accessor :idioms, :words
end