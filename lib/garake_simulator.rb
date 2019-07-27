module GarakeSimulator
  extend self

  KEY_MAP = {
    '1' => %w(. , ! ?) << ' ',
    '2' => %w(a b c),
    '3' => %w(d e f),
    '4' => %w(g h i),
    '5' => %w(j k l),
    '6' => %w(m n o),
    '7' => %w(p q r s),
    '8' => %w(t u v),
    '9' => %w(w x y z),
  }

  def simulate(key_string)
    before_input_key = nil
    input_count = 0
    result = ''

    key_string.chars.each do |key|
      # 確定
      if key == '0'
        result += key_to_char(before_input_key, input_count) if before_input_key

        before_input_key = nil
        input_count = 0
        next
      end

      # 確定以外のキー
      if key == before_input_key then
        input_count += 1
      else
        before_input_key = key
        input_count = 1
      end
    end

    result
  end

  private
    def key_to_char(key, count)
      raise NotImplementedError(key) unless KEY_MAP.include?(key)

      cycle_chars = KEY_MAP[key]
      cycle_chars[(count-1) % cycle_chars.size]
    end
end

if __FILE__ == $PROGRAM_NAME
  while line = gets
    puts GarakeSimulator.simulate(line)
  end
end
