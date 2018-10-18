require 'twitter'
require 'dotenv'
require 'json'
require 'pp'

class Handle

  def recherche_handle(ville)

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["config.consumer_key"]
      config.consumer_secret     = ENV["config.consumer_secret"]
      config.access_token        = ENV["config.access_token"]
      config.access_token_secret = ENV["config.access_token_secret"]
    end

    begin
      x = @client.user_search("mairie " + ville)
      puts x[0].screen_name
      return x[0].screen_name
      rescue
        puts "No Twitter"
    end
  end

  def perform


    json = File.read('db/townhalls.json')
    array = JSON.parse(json)

    array.each do |l|
      at = recherche_handle(l["ville"])
      l["handle_twitter"] = at
    end

    File.open("db/townhalls.json","w") do |f|
      f.write(array.to_json)
    end
  end
end
