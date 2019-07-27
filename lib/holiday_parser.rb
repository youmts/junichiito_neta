require 'date'

module HolidayParser
  extend self

  def parse(csv)
    lines = csv.split("\n")
    lines.slice(0, 1) # 最初の２行は無視

    ret = {}
    lines.each do |line|
      # 隣接する2セルを祝日名と日付の組み合わせとして処理する
      line.split(",").each_slice(2) do |name, date_string|
        date = Date.strptime(date_string, '%Y/%m/%d')

        ret[date.year] = {} unless ret.include?(date.year)
        ret[date.year][date] = name
      rescue
        # 空白とか、無意味なセルは無視する
      end
    end

    ret
  end
end