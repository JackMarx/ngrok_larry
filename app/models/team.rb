class Team < ActiveRecord::Base
  has_many :events
  
  def client
    Slack.configure { |config| config.token = bot_access_token }
    Slack::Web::Client.new
  end

  def send_response(channel, message)
      client.chat_postMessage(
        as_user: 'true',
        channel: channel,
        text: message
      )
  end
end
