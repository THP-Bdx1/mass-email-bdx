require 'twitter'
require 'dotenv'
require 'json'
require '../db/townhalls.json'
Dotenv.load


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["config.consumer_key"]
  config.consumer_secret     = ENV["config.consumer_secret"]
  config.access_token        = ENV["config.access_token"]
  config.access_token_secret = ENV["config.access_token_secret"]
end


def twitter_follow(ville) #methode pour follow les "@ville"
client.follow(ville)
end