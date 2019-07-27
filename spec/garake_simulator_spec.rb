require 'spec_helper'

describe GarakeSimulator do
  example { expect(GarakeSimulator.simulate('10')).to eq '.' }
  example { expect(GarakeSimulator.simulate('110')).to eq ',' }
  example { expect(GarakeSimulator.simulate('1110')).to eq '!' }
  example { expect(GarakeSimulator.simulate('11110')).to eq '?' }
  example { expect(GarakeSimulator.simulate('111110')).to eq ' ' }
  example { expect(GarakeSimulator.simulate('1111110')).to eq '.' }

  example { expect(GarakeSimulator.simulate('20')).to eq 'a' }
  example { expect(GarakeSimulator.simulate('220')).to eq 'b' }
  example { expect(GarakeSimulator.simulate('2220')).to eq 'c' }
  example { expect(GarakeSimulator.simulate('22220')).to eq 'a' }

  example { expect(GarakeSimulator.simulate('30')).to eq 'd' }
  example { expect(GarakeSimulator.simulate('330')).to eq 'e' }
  example { expect(GarakeSimulator.simulate('3330')).to eq 'f' }
  example { expect(GarakeSimulator.simulate('33330')).to eq 'd' }

  example { expect(GarakeSimulator.simulate('40')).to eq 'g' }
  example { expect(GarakeSimulator.simulate('440')).to eq 'h' }
  example { expect(GarakeSimulator.simulate('4440')).to eq 'i' }
  example { expect(GarakeSimulator.simulate('44440')).to eq 'g' }

  example { expect(GarakeSimulator.simulate('50')).to eq 'j' }
  example { expect(GarakeSimulator.simulate('550')).to eq 'k' }
  example { expect(GarakeSimulator.simulate('5550')).to eq 'l' }
  example { expect(GarakeSimulator.simulate('55550')).to eq 'j' }

  example { expect(GarakeSimulator.simulate('60')).to eq 'm' }
  example { expect(GarakeSimulator.simulate('660')).to eq 'n' }
  example { expect(GarakeSimulator.simulate('6660')).to eq 'o' }
  example { expect(GarakeSimulator.simulate('66660')).to eq 'm' }

  example { expect(GarakeSimulator.simulate('70')).to eq 'p' }
  example { expect(GarakeSimulator.simulate('770')).to eq 'q' }
  example { expect(GarakeSimulator.simulate('7770')).to eq 'r' }
  example { expect(GarakeSimulator.simulate('77770')).to eq 's' }
  example { expect(GarakeSimulator.simulate('777770')).to eq 'p' }

  example { expect(GarakeSimulator.simulate('80')).to eq 't' }
  example { expect(GarakeSimulator.simulate('880')).to eq 'u' }
  example { expect(GarakeSimulator.simulate('8880')).to eq 'v' }
  example { expect(GarakeSimulator.simulate('88880')).to eq 't' }

  example { expect(GarakeSimulator.simulate('90')).to eq 'w' }
  example { expect(GarakeSimulator.simulate('990')).to eq 'x' }
  example { expect(GarakeSimulator.simulate('9990')).to eq 'y' }
  example { expect(GarakeSimulator.simulate('99990')).to eq 'z' }
  example { expect(GarakeSimulator.simulate('999990')).to eq 'w' }

  example '同じ文字を繰り返し入力' do
    expect(GarakeSimulator.simulate( '10110')).to eq '.,'
  end

  example '入力なしで決定' do
    expect(GarakeSimulator.simulate('0')).to eq ''
  end

  example { expect(GarakeSimulator.simulate( '44033055505550666011011111090666077705550301110')).to eq 'hello, world!'}
  example { expect(GarakeSimulator.simulate( '000555555550000330000444000080000200004440000')).to eq 'keitai'}
end
