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
      @client = TwitterOAuth::Client.new(
        :consumer_key    => @consumer['consumer_key'],
        :consumer_secret => @consumer['consumer_secret']
      )

      request_token = @client.authentication_request_token(
        :oauth_callback => 'oob'
      )

      puts "You need to authorize this app with the Twitter account."
      puts "Please visit this URL and type in the PIN here:"
      puts request_token.authorize_url
      print "PIN: "
      code = gets.strip

      access_token = @client.authorize(
        request_token.token,
        request_token.secret,
        :oauth_verifier => code
      )

      File.open('tokens.json', 'w') do |f|
        f.write(JSON.dump({'token' => access_token.token, 'secret' => access_token.secret}))
      end
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
