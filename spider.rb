require 'mongo'
require 'nokogiri'
require 'httparty'
require 'byebug'


def spider
	url = "http://quotes.toscrape.com/"
	unparsed_page = HTTParty.get(url)
	parsed_page = Nokogiri::HTML(unparsed_page)
	list_of_quotes = parsed_page.css('div.quote')
	list_of_quotes.each do |q|
		quote = {
			quote: q.css('span.text').text,
			author: q.css('small.author').text,
			author_about: "http://quotes.toscrape.com" + q.css('a')[0].attributes["href"].value,
			tags: q.css('a.tag').map{|tag| tag.text}
		}
	end

end

spider