require 'json'
require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'gmail'
require 'dotenv'

class Mailing

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  APPLICATION_NAME = 'Gmail API Ruby Quickstart'.freeze
  CREDENTIALS_PATH = 'db/credentials.json'.freeze
  TOKEN_PATH = 'db/token.yaml'.freeze
  SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

  def authorize
    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def perform
# Initialize the API
  service = Google::Apis::GmailV1::GmailService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize

# Show the user's labels
  user_id = 'me'

    gmail = Gmail.connect!(ENV["account"],ENV["password"])

    json=File.read("db/townhalls.json")
    obj=JSON.parse(json)
    obj.each do |k|
      gmail.deliver do
        to "#{k["mail"]}"
        subject "Apprendre à coder, une nouvelle pédagogie"
        text_part do
          body "Bonjour,
  Je m'appelle William, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

  Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{k["ville"]} veut changer le monde avec nous ?


  Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
        end
      end
    end
  end
end
