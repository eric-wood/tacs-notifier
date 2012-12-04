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

# Sort descending (first event is most recent)
events.sort! { |a,b| b.start <=> a.start }

# Remove all but the upcoming events
events.reject! { |e| e.start < DateTime.now }
tweeted = File.open('tweeted.txt').read.split

# Remove previously tweeted events
events.reject! { |e| tweeted.include?(e.id) }

# Tweet if the event is happening within 24 hours
events.reject! { |e| (e.start - 24) >= DateTime.now }

events.each do |event|
  # Note that we tweeted about this event!
  File.open('tweeted.txt', 'a') do |f|
    f.write("{event.id}\n")
  end

  tweet = config['tweet_string']
  tweet.gsub!(/%t/, event.title)
  tweet.gsub!(/%u/, event.url)
  tweeter.tweet(tweet)
end

