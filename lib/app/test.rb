require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'mime/types'
require 'rmail'
require 'gmail'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Gmail API Ruby Quickstart'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
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

# Initialize the API
service = Google::Apis::GmailV1::GmailService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Show the user's labels
user_id = 'me'
result = service.list_user_labels(user_id)


=begin
def send(body, client_id)
      gmail = Google::Apis::GmailV1::Message.new
      gmail.authorization = authorize
      message = RMail::Message.new
      message.header['To'] = "mr.willh@gmail.com"
      message.header['From'] = "mr.willh@gmail.com"
      message.header['Subject'] = "hello"
      message.body = body

      gmail.send_user_message('me',
                              upload_source: StringIO.new(message.to_s),
                              content_type: 'message/rfc822')
end

send("hello", Google::Auth::ClientId.from_file(CREDENTIALS_PATH))
=end
=begin
class Mail
    
    def Initialize

    end
end

class Time
end
=end
=begin
class Mail

    def Initialize(to,from,subject,body)
        @to=to
        @from=from
        @subject=subject
        @body=body
    end

end
m = Mail.new(to:"mr.willh@gmail.com", from:"mr.willh@gmail.com", subject:"J'apprends à coder",
body:"Bonjour,
Je m'appelle William, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de [NOM_COMMUNE] veut changer le monde avec nous ?


Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80")

msg = m.encoded 
# or m.to_s
# this doesn't base64 encode. It just turns the Mail::Message object into an appropriate string.

message_object = Google::Apis::GmailV1::Message.new(raw:m.to_s)
client.send_user_message("me", message_object)
=begin
def send_message(service, user_id, message)
  """Bonjour,
Je m'appelle William, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de [NOM_COMMUNE] veut changer le monde avec nous ?


Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80
  """
    message = (service.users().messages().send(userId=user_id, body=message)
               .execute())
    print 'Message Id: %s' % message['id']
    return message
end
=end
