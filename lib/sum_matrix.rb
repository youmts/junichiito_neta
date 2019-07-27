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

# 行列を画面出力用の文字列に変換する
def print_matrix(matrix)
  # すべてのセルを文字列化する
  text_matrix = matrix.map { |row| row.map { |x| x.to_s } }

  # 各カラムの最大文字数を計算
  cols_size_max = Array.new(text_matrix[0].size, 0)
  text_matrix.each do |row|
    row.each_with_index do |x, idx|
      cols_size_max[idx] = x.size if cols_size_max[idx] < x.size
    end
  end

  # すべてのセルをjoinし、すべての行をjoinする
  text_matrix.map { |row|
    row.map.with_index { |x, idx| sprintf("%#{cols_size_max[idx]}d", x) }.join("| ")
  }.join("\n")
end

if __FILE__ == $PROGRAM_NAME
  # n行✕m列の行列をランダム初期化する
  sum_matrix = SumMatrix.new
  r = Random.new()
  n = r.rand(1..10)
  m = r.rand(1..10)
  input = Array.new(n) { Array.new(m) { r.rand(1000) } }

  # 合計を計算して出力
  output = sum_matrix.run(input)
  puts print_matrix(output)
end
