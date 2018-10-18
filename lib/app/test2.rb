require 'google/apis/gmail_v1'

def redirect
  client = Signet::OAuth2::Client.new({
    client_id: ENV['client_id'],
    client_secret: ENV['client_secret'],
    authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
    scope: Google::Apis::GmailV1::AUTH_GMAIL_READONLY,
    redirect_uri: url_for(:action => :callback)
  })

  redirect_to client.authorization_uri.to_s
end

redirect
user_id = 'me'
result = service.list_user_labels(user_id)
puts 'Labels:'
puts 'No labels found' if result.labels.empty?
result.labels.each { |label| puts "- #{label.name}" }
