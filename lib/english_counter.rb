require 'pp'

module EnglishCounter
  extend self

  def parse(input)
    # 熟語と単語を、熟語を優先的にマッチさせる正規表現を生成
    word_char = '[-\w\/’]'
    word = "#{word_char}+"
    idiom_word = "[A-Z]#{word_char}*"
    idiom_separator = "(?:\s+|\s+of\s+)"
    word_regexp = /#{word}/
    idiom_regexp = /#{idiom_word}(?:#{idiom_separator}#{idiom_word})+/
    regexp = Regexp.union(idiom_regexp, word_regexp)

    # 熟語か単語の出現回数を示すハッシュを作成
    all = input.scan(regexp).each_with_object Hash.new(0) do |word, result|
      result[word] += 1
    end

    # 熟語と単語のハッシュに分割
    part = all.partition { |key, _| key.match? idiom_regexp }
    make_result *part
  end

  private
    def make_result(idiom_hash, word_hash)
      result = {}
      result[:idioms]= hash_to_array(idiom_hash)
      result[:words] = hash_to_array(word_hash)
      result
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

if __FILE__ == $PROGRAM_NAME
  if ARGV.size < 1
    puts "usage: ruby lib/english_counter.rb sample/english.txt"
    return
  end

  pp EnglishCounter.parse File.open(ARGV[0]).read
end