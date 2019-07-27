require 'spec_helper'
require 'date'

describe HolidayParser do
  example do
    input = <<-'EOS'
平成28年（2016年）,,平成29年（2017年）,,平成30年（2018年）,
名称,月日,名称,月日,名称,月日
元日,2016/1/1,元日,2017/1/1,元日,2018/1/1
成人の日,2016/1/11,成人の日,2017/1/9,成人の日,2018/1/8
,,,,,
月日は表示するアプリケーションによって形式が異なる場合があります。,,,,,
    EOS

    expected = {
      2016 => {
        Date.new(2016, 1, 1) => "元日",
        Date.new(2016, 1, 11) => "成人の日",
      },
      2017 => {
        Date.new(2017, 1, 1) => "元日",
        Date.new(2017, 1, 9) => "成人の日",
      },
      2018 => {
        Date.new(2018, 1, 1) => "元日",
        Date.new(2018, 1, 8) => "成人の日",
      },
    }

    expect(HolidayParser.parse(input)).to eq expected
  end
end