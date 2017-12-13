class EventsController < Sinatra::Base  
  post '/events' do
    request_data = JSON.parse(request.body.read)
    
    case request_data['type']
      when 'url_verification' #used to verify event subscripitons
        p request_data['challenge']
      when 'event_callback' #used to handle events

        team = Team.find_by(team_id: request_data['team_id'])

        event_data = request_data['event']
        event = Event.new(
                          team_id: team.id,
                          user_reference: event_data['user'],
                          type_label: event_data['type'],
                          subtype_label: event_data['subtype'],
                          channel: event_data['channel'] || event_data['channel_id'],
                          event_text: event_data['text']
                          )

        break unless event.valid?

        case event.type_label
          when 'pin_added'
            event.respond_with "So you like pinning things, do ya?"
          when 'pin_removed'
            event.respond_with "You can always repin this later."
          when 'message'
            event.message
          else
            puts "Unexpected event:\n"
            puts JSON.pretty_generate(request_data)
        end
      end
    
    status 200
  end
end