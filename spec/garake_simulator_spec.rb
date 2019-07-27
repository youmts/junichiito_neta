require 'spec_helper'

describe GarakeSimulator do
  let(:simulator) { GarakeSimulator.new }

  example { expect(simulator.run('10')).to eq '.' }
  example { expect(simulator.run('110')).to eq ',' }
  example { expect(simulator.run('1110')).to eq '!' }
  example { expect(simulator.run('11110')).to eq '?' }
  example { expect(simulator.run('111110')).to eq ' ' }
  example { expect(simulator.run('1111110')).to eq '.' }

  example { expect(simulator.run('20')).to eq 'a' }
  example { expect(simulator.run('220')).to eq 'b' }
  example { expect(simulator.run('2220')).to eq 'c' }
  example { expect(simulator.run('22220')).to eq 'a' }

  example { expect(simulator.run('30')).to eq 'd' }
  example { expect(simulator.run('330')).to eq 'e' }
  example { expect(simulator.run('3330')).to eq 'f' }
  example { expect(simulator.run('33330')).to eq 'd' }

  example { expect(simulator.run('40')).to eq 'g' }
  example { expect(simulator.run('440')).to eq 'h' }
  example { expect(simulator.run('4440')).to eq 'i' }
  example { expect(simulator.run('44440')).to eq 'g' }

  example { expect(simulator.run('50')).to eq 'j' }
  example { expect(simulator.run('550')).to eq 'k' }
  example { expect(simulator.run('5550')).to eq 'l' }
  example { expect(simulator.run('55550')).to eq 'j' }

  example { expect(simulator.run('60')).to eq 'm' }
  example { expect(simulator.run('660')).to eq 'n' }
  example { expect(simulator.run('6660')).to eq 'o' }
  example { expect(simulator.run('66660')).to eq 'm' }

  example { expect(simulator.run('70')).to eq 'p' }
  example { expect(simulator.run('770')).to eq 'q' }
  example { expect(simulator.run('7770')).to eq 'r' }
  example { expect(simulator.run('77770')).to eq 's' }
  example { expect(simulator.run('777770')).to eq 'p' }

  example { expect(simulator.run('80')).to eq 't' }
  example { expect(simulator.run('880')).to eq 'u' }
  example { expect(simulator.run('8880')).to eq 'v' }
  example { expect(simulator.run('88880')).to eq 't' }

  example { expect(simulator.run('90')).to eq 'w' }
  example { expect(simulator.run('990')).to eq 'x' }
  example { expect(simulator.run('9990')).to eq 'y' }
  example { expect(simulator.run('99990')).to eq 'z' }
  example { expect(simulator.run('999990')).to eq 'w' }

  example '同じ文字を繰り返し入力' do
    expect(simulator.run( '10110')).to eq '.,'
  end

  example '入力なしで決定' do
    expect(simulator.run('0')).to eq ''
  end

  example { expect(simulator.run( '44033055505550666011011111090666077705550301110')).to eq 'hello, world!'}
  example { expect(simulator.run( '000555555550000330000444000080000200004440000')).to eq 'keitai'}
end
