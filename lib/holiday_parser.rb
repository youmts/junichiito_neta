require 'date'

module HolidayParser
  extend self

  def parse(csv)
    lines = csv.split("\n")

    # 最初の２行は無視する
    days = create_days_hash(lines.slice(2, lines.size - 2))
    ret = {}
    days.each do |date, name|
      ret[date.year] = {} unless ret.include?(date.year)
      ret[date.year][date] = name
    end

    ret
  end

  def create_days_hash(days_lines)
    ret = {}
    days_lines.each do |line|
      line.split(",").each_slice(2) do |name, date_string|
        ret[Date.strptime(date_string, '%Y/%m/%d')] = name
      rescue
        # 空白とか、無意味なセルは無視する
      end
    end
    ret
  end
end