require 'json'
require_relative 'tweeter.rb'
require_relative 'scraper.rb'

config = {}

begin
  config = JSON.parse(open('config.json').read)
rescue
  puts "Missing or corrupt config file. Make sure config.json exists and is valid!"
  exit 1
end

tweeter = Tweeter.new
scraper = Scraper.new(config['calendar_url'])

scraper.scrape
events = scraper.events
event = events.first

# TODO: logic for checking dates/times
tweet = config['tweet_string']
tweet.gsub!(/%t/, event.title)
tweet.gsub!(/%u/, event.url)
tweeter.tweet(tweet)
