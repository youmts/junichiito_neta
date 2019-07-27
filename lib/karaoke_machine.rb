class KaraokeMachine
  SCALES = %w[C C# D D# E F F# G G# A A# B]

  def initialize(melody)
    @melody_tokens = tokenize(melody)
  end

  def transpose(change_key)
    @melody_tokens.map { |x| transpose_token(x, change_key) }.join
  end

  private
    # melodyを一音ずつに分解したArrayを返す
    # 音でないもの（スペースや縦棒）は一文字ずつ要素にする
    def tokenize(melody)
      ret = []
      index = 0
      while index < melody.size do
        # 二文字の音階を優先して判定する
        if SCALES.include?((two = melody[index, 2]))
          ret << two
          index += 2
          next
        end

        # それ以外は音でないものか、一文字の音階なので一文字分を入れる
        ret << melody[index]
        index += 1
      end
      ret
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