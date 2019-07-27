require 'spec_helper'

describe SumMatrix do
  example "sum_matrix" do
    input = [
        [9, 85, 92, 20],
        [68, 25, 80, 55],
        [43, 96, 71, 73],
        [43, 19, 20, 87],
        [95, 66, 73, 62]
    ]
    expected = [
        [9, 85, 92, 20, 206],
        [68, 25, 80, 55, 228],
        [43, 96, 71, 73, 283],
        [43, 19, 20, 87, 169],
        [95, 66, 73, 62, 296],
        [258, 291, 336, 297, 1182]
    ]

    expect(SumMatrix.sum_matrix(input)).to eq expected
  end

  example "print_matrix" do
    input = [
      [9, 85, 92],
      [68, 25, 80],
      [43, 96, 71],
    ]

    expect(SumMatrix.print_matrix(input)).to eq <<~'EOS'.chop
     9| 85| 92
    68| 25| 80
    43| 96| 71
    EOS
  end
end

