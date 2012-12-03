require_relative 'scraper.rb'

scraper = Scraper.new('http://www.google.com/calendar/feeds/tacs%40aggieacm.org/public/full')

scraper.scrape
scraper.events
