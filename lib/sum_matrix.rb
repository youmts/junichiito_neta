class SumMatrix
  def run(input)
    result = []

    # 最終行以外
    input.each do |row|
      new_row = row.clone
      new_row << row.sum

      result << new_row
    end

    # 最終行
    result << result.inject(Array.new(result[0].size, 0)) do |memo, row|
      row.each_with_index { |x, idx| memo[idx] += x }
      memo
    end

    result
  end
end