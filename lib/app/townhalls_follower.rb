require 'twitter'
require 'dotenv'
require 'json'

class Follow

  def perform
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["config.consumer_key"]
      config.consumer_secret     = ENV["config.consumer_secret"]
      config.access_token        = ENV["config.access_token"]
      config.access_token_secret = ENV["config.access_token_secret"]
    end


    json = File.read('db/townhalls.json')
    obj = JSON.parse(json)

    obj.each do |l|
      if l["handle_twitter"] != nil
        a=l["handle_twitter"]
        client.follow(a.to_s)
      end
    end
  end
end
