
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'google/apis/gmail_v1'
require 'base_cli'
require 'rmail'

module Samples
  # Examples for the Gmail API
  #
  # Sample usage:
  #
  #     $ ./google-api-samples gmail send 'Hello there!' \
  #       --to='recipient@example.com' --from='user@example.com' \
  #       --subject='Hello'
  #
  class Gmail < BaseCli
    Gmail = Google::Apis::GmailV1

    desc 'get ID', 'Get a message for an id with the gmail API'
    def get(id)
      gmail = Gmail::GmailService.new
      gmail.authorization = user_credentials_for(Gmail::AUTH_SCOPE)

      result = gmail.get_user_message('me', id)
      payload = result.payload
      headers = payload.headers

      date = headers.any? { |h| h.name == 'Date' } ? headers.find { |h| h.name == 'Date' }.value : ''
      from = headers.any? { |h| h.name == 'From' } ? headers.find { |h| h.name == 'From' }.value : ''
      to = headers.any? { |h| h.name == 'To' } ? headers.find { |h| h.name == 'To' }.value : ''
      subject = headers.any? { |h| h.name == 'Subject' } ? headers.find { |h| h.name == 'Subject' }.value : ''

      body = payload.body.data
      if body.nil? && payload.parts.any?
        body = payload.parts.map { |part| part.body.data }.join
      end

      puts "id: #{result.id}"
      puts "date: #{date}"
      puts "from: #{from}"
      puts "to: #{to}"
      puts "subject: #{subject}"
      puts "body: #{body}"
    end

    desc 'send TEXT', 'Send a message with the gmail API'
    method_option :to, type: :string, required: true
    method_option :from, type: :string, required: true
    method_option :subject, type: :string, required: true
    def send(body)
      gmail = Gmail::GmailService.new
      gmail.authorization = user_credentials_for(Gmail::AUTH_SCOPE)

      message = RMail::Message.new
      message.header['To'] = options[:to]
      message.header['From'] = options[:from]
      message.header['Subject'] = options[:subject]
      message.body = body

      gmail.send_user_message('me',
                              upload_source: StringIO.new(message.to_s),
                              content_type: 'message/rfc822')
    end
end