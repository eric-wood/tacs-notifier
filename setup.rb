#############################################
# Run this file to set up auth and whatnot! #
#############################################

require 'json'
require 'twitter_oauth'

begin
  @consumer = JSON.parse(open('config.json').read)
rescue
  puts "Missing or corrupt config file. Make sure config.json exists and is valid!"
  exit 1
end

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
