require 'json'
require 'twitter'

data = JSON.parse(open('config.json').read)

Twitter.configure do |config|
  config.consumer_key       = data['consumer_key']
  config.consumer_secret    = data['consumer_secret']
  config.oauth_token        = data['access_token']
  config.oauth_token_secret = data['access_secret']
end

Twitter.update("Testing. 1.2.3")
