require_relative 'tweeter.rb'
require_relative 'scraper.rb'

tweeter = Tweeter.new
scraper = Scraper.new('http://www.google.com/calendar/feeds/tacs%40aggieacm.org/public/full')

scraper.scrape
events = scraper.events
event = events.first
tweeter.tweet("Meeting tomorrow: #{event.title} -- #{event.url}")
