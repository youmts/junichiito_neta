require 'date'

module HolidayParser
  extend self

  def parse(csv)
    lines = csv.split("\n")

    # 最初の行は年のリスト
    ret = create_year_hash(lines[0])

    days = create_days_hash(lines.slice(2, lines.size - 2))

    days.each do |date, name|
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

  def create_year_hash(year_line)
    ret = {}
    year_line.split(",").select.with_index {|_, index| index % 2 == 0}.each do |cell|
      ret[to_year(cell)] = {}
    end
    ret
  end

  def to_year(year_cell_string)
    /（(\d+)年）/.match(year_cell_string).to_a[1].to_i
  end

end