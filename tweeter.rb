require 'json'
require 'twitter_oauth'

class Tweeter
  def initialize
    @consumer = JSON.parse(open('config.json').read)
    @tokens = JSON.parse(open('tokens.json').read) if File.exist?('tokens.json')

    if @tokens
      puts "Found existing login credentials."
      @client = TwitterOAuth::Client.new(
        :consumer_key    => @consumer['consumer_key'],
        :consumer_secret => @consumer['consumer_secret'],
        :token           => @tokens['token'],
        :secret          => @tokens['secret']
      )
    else
      puts "Missing OAuth tokens! You need to run setup.rb to generate these and authenticate with Twitter"
      exit 1
    end

    unless @client.authorized?
      puts "Something went wrong, and authorization failed."
      puts "If Eric had bothered with error checking maybe this error would be useful"
    end
  end

  def tweet(text)
    @client.update(text)
  end
end
