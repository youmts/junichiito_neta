class KaraokeMachine
  def initialize(melody)
    @melody_tokens = tokenize(melody)
  end

  def transpose(change_key)
    @melody_tokens.map { |x| transpose_token(x, change_key) }.join
  end

  private
    # melodyを一音ずつに分解したArrayを返す
    # 音でないもの（スペースや縦棒）も要素にする
    def tokenize(melody)
      scales = "CDEFGAB"
      sharps = /[#{scales}]#/
      normal = /[#{scales}]/
      others = /[^#{scales}]+/
      regexp = Regexp.union(sharps, normal, others) # 左から優先でマッチさせる

      melody.scan(regexp)
    end

    # 一つのトークンをキーチェンジする
    # 音階はchange_key分キーを変更して返す
    # 音階でないものはそのまま返す
    def transpose_token(token, change_key)
      return token unless SCALES.include?(token)

      index = SCALES.find_index(token)
      SCALES[(index + change_key) % SCALES.size]
    end
end