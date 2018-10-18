require 'twitter'
require 'dotenv'
require 'json'
require 'pp'

Dotenv.load #On charge les API twitter du fichier ".env"


def recherche_handle(ville)
  
  client = Twitter::REST::Client.new do |config|   
  config.consumer_key        = ENV["config.consumer_key"]
  config.consumer_secret     = ENV["config.consumer_secret"]
  config.access_token        = ENV["config.access_token"]
  config.access_token_secret = ENV["config.access_token_secret"]
end
	x = client.user_search("mairie " + ville )
	return x[0].screen_name

end

json = File.read('../../db/townhalls.json')
obj = JSON.parse(json)

obj.each do |l|
	at = recherche_handle(l["Name"])
	next if nil
	l["handle_twitter"] = at

end
