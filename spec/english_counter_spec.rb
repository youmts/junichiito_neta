require 'spec_helper'

describe EnglishCounter do
  example "単語" do
    expected = { idioms: [], words: [[1, "aaa"]] }
    expect(EnglishCounter.parse("aaa")).to eq expected
  end

  example "二つの単語" do
    expected = { idioms: [], words: [[1, "50"], [1, "aaa"]] }
    expect(EnglishCounter.parse("aaa 50")).to eq expected
  end

  example "ハイフンを含む単語" do
    expected = { idioms: [], words: [[1, "first-ever"]]}
    expect(EnglishCounter.parse("first-ever")).to eq expected
  end

  example "スラッシュを含む単語" do
    expected = { idioms: [], words: [[1, "I/O"]]}
    expect(EnglishCounter.parse("I/O")).to eq expected
  end

  example "アポストロフィを含む単語" do
    expected = { idioms: [], words: [[1, "Apple’s"]]}
    expect(EnglishCounter.parse("Apple’s")).to eq expected
  end

  example "２単語の熟語" do
    expected = { idioms: [[1, "Aaa Bbb"]], words: [] }
    expect(EnglishCounter.parse("Aaa Bbb")).to eq expected
  end

  example "連続空白を含む熟語" do
    expected = { idioms: [[1, "Aaa  Bbb"]], words: [] }
    expect(EnglishCounter.parse("Aaa  Bbb")).to eq expected
  end

  example "３単語の熟語" do
    expected = { idioms: [[1, "Aaa Bbb Ccc"]], words: [] }
    expect(EnglishCounter.parse("Aaa Bbb Ccc")).to eq expected
  end

  example "ofを含む熟語" do
    expected = { idioms: [[1, "Aaa of Ccc"]], words: [] }
    expect(EnglishCounter.parse("Aaa of Ccc")).to eq expected
  end

  example "ofで終わる文字列は単語として扱われること" do
    expected = { idioms: [], words: [[1, "Best"], [1, "of"]] }
    expect(EnglishCounter.parse("Best of")).to eq expected
  end
end