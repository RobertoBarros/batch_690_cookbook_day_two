class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    doc = Nokogiri::HTML(URI.open(url).read, nil, 'utf-8')

    titles = []
    urls = []
    doc.search('.card__recipe').first(5).each do |card|
      titles <<  card.search('h3').text.strip
      urls << card.search('a.card__titleLink').attribute('href').value
    end

    titles.each_with_index do |title, index|
      puts "#{index + 1} - #{title}"
    end
    puts 'Enter recipe number to import:'
    index = gets.chomp.to_i - 1

    url = urls[index]
    doc = Nokogiri::HTML(URI.open(url).read, nil, 'utf-8')

    name = doc.search('h1').text
    description = doc.search('.recipe-summary').text.strip
    rating =  doc.search('.review-star-text').first.text.strip.match(/Rating: (\d\.\d{2})/)[1].to_f.round(0)
    prep_time = doc.search('.recipe-meta-item-body')[0].text

    Recipe.new(name, description, rating, prep_time)
  end
end
