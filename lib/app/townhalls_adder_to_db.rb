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
begin
	x = client.user_search("mairie " + ville )
	return x[0].screen_name
	rescue

end
end

json = File.read('../../db/townhalls.json')
array = JSON.parse(json)

array.each do |l|
	at = recherche_handle(l["Name"])
	l["handle_twitter"] = at
end
	  File.open("../../db/townhalls.json","w") do |f|
            f.write(array.to_json)
            end