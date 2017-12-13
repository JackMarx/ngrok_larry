class AuthController < Sinatra::Base
  add_to_slack_button = %(
    <a href=\"https://slack.com/oauth/authorize?scope=bot&client_id=#{ENV["SLACK_CLIENT_ID"]}&redirect_uri=#{ENV["SLACK_REDIRECT_URI"]}\">
      <img alt=\"Add to Slack\" height=\"40\" width=\"139\" src=\"https://platform.slack-edge.com/img/add_to_slack.png\"/>
    </a>
  )

  get '/' do
    redirect '/begin_auth'
  end

  get '/begin_auth' do
    status 200
    body add_to_slack_button
  end

  get '/finish_auth' do
    begin
      response = Slack::Web::Client.new.oauth_access(
                                                      client_id: ENV["SLACK_CLIENT_ID"],
                                                      client_secret: ENV["SLACK_API_SECRET"],
                                                      redirect_uri: ENV["SLACK_REDIRECT_URI"],
                                                      code: params[:code]
                                                     )

      team = Team.find_or_create_by(team_id: response['team_id'])
      team.update(
                   user_access_token: response['access_token'],
                   bot_user_id: response['bot']['bot_user_id'],
                   bot_access_token: response['bot']['bot_access_token']
                 )

      status 200
      body "#{add_to_slack_button}<h2>You're app is authorized</h2><h3>If you need to renew your token click the button again.</h3>"
    rescue Slack::Web::Api::Error => e
      status 403
      body "#{add_to_slack_button}<h2>Authorization failed!</h2><h3>Reason: #{e.message}</h3>"
    end
  end
end