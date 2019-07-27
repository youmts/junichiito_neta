require 'spec_helper'

describe KaraokeMachine do
  example "音階を一つ上げると次の音階になること" do
    SCALES = %w[C C# D D# E F F# G G# A A# B]

    expected_scales = SCALES.clone
    expected_scales.shift
    expected_scales << "C"

    SCALES.zip(expected_scales).each do |input, expected|
      machine = KaraokeMachine.new(input)
      expect(machine.transpose(1)).to eq expected
    end
  end

  example "音階を一つ下げると一つ下の音階になること" do
    machine = KaraokeMachine.new("C")
    expect(machine.transpose(-1)).to eq "B"
  end

  example "音階を二つあげると二つ上の音階になること" do
    machine = KaraokeMachine.new("C")
    expect(machine.transpose(2)).to eq "D"
  end

  example "音階を12あげると同じ音階になること" do
    machine = KaraokeMachine.new("C")
    expect(machine.transpose(12)).to eq "C"
  end

  example "スペースや縦棒が入っているメロディがキーチェンジできること" do
    machine = KaraokeMachine.new("C |D")
    expect(machine.transpose(1)).to eq("C# |D#")
  end

  example "長いメロディがキーチェンジできること" do
    machine = KaraokeMachine.new("C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   ")
    expect(machine.transpose(2)).to eq("D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   ")
    expect(machine.transpose(-1)).to eq("B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   ")
  end
end