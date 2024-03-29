require 'spec_helper'

describe EnglishCounter do
  example "" do
    input = <<~"EOS"
      Interior design and decorating resource Houzz is the overall best Android app of the year, according to Google, which this evening announced the results of the first-ever Google Play Awards at its developer conference, Google I/O. While in previous years, the company had rounded up large numbers of apps for “Best of” lists, the new Google Play Awards instead follows Apple’s model of selecting winners across a variety of categories.
      But where Apple chooses best apps for phone, tablet, and watch, along with selections like “most innovative,” Google took a somewhat different path. It selected 5 nominees across 10 categories, and didn’t differentiate between those built for tablet or phone.
      Google also nominated apps that reflected a group of developers who were taking the best advantage of Google’s services, like “Best Use of Google Play Game Services,” plus those who did the best job of implementing Google’s newer design language, Material Design.
      And Google didn’t limit itself to only one category focused on innovation, but chose several angles – including not only the “most innovative” app, but also “Standout Startup” and “Early Adopter. The move was likely meant to signal that not all of the best and most creative new apps are exclusive to iOS, or launched on iOS first.
      The company live-streamed the ceremony this evening from Google I/O, which was also a change from previous years.
      On stage, the company spoke of Google Play’s evolution and noted that the online storefront now reaches over a billion users daily. Apps are obviously a huge draw for this store – earlier this week, Google said that app installs from Google Play had reached 65 billion in the past year.
      The winning apps were chosen by a panel of experts at Google, and rated on several factors, including app quality and innovation. To be considered, the apps either needed to have launched or had a major update over the last 12 months.
      Houzz ended up winning the “Best App” title, beating out BuzzFeed News, Colorfy, TuneIn Radio and Yummly.
      Meanwhile, the hugely popular Clash Royale walked away with the “Best Game” crown, topping Alphabear, Clash of Kings, MARVEL Future Fight, and Star Wars Galaxy of Heroes.
      From the startup world, the smart airfare prediction engine Hopper won “Best Standout Startup” and millennial-focused investing app Robinhood grabbed the win for “Best Use of Material Design.”
    EOS

    result = EnglishCounter.parse(input)

    idioms_expected = [
      [2, "Google I/O"],
      [2, "Google Play Awards"],
      [1, "And Google"],
      [1, "Best App"],
      [1, "Best Game"],
      [1, "Best of"],
      [1, "Best Standout Startup"],
      [1, "Best Use of Google Play Game Services"],
      [1, "Best Use of Material Design"],
    ]
    expect(result.idioms.slice(0, idioms_expected.size)).to eq idioms_expected

    words_expected = [
      [22, "the"],
      [11, "and"],
      [11, "of"],
      [8, "a"],
      [6, "apps"],
      [5, "app"],
      [5, "best"],
      [5, "for"],
      [5, "Google"],
      [5, "to"],
      [4, "that"],
      [4, "this"],
    ]
    expect(result.words.slice(0, words_expected.size)).to eq words_expected

    expect(result.words.sum { |x| x[0] }).to eq 331
  end
end