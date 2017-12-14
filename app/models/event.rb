class Event < ActiveRecord::Base
  belongs_to :team

# Validation to prevent duplicates

  def valid?
    if team.bot_user_id == user_reference #alt check for all bots --> Team.find_by(bot_user_id: user_reference)
      puts "*** This is a message by your bot."
      return false 
    end
    
    if type_label == 'message' && !event_text
      puts "*** message has no content to analyze."
      return false 
    end

    if subtype_label
      puts "*** There is a subtype of #{subtype_label}, which means it's probably a duplicate."
      return false 
    end

    puts "*** this is a valid message."
    true
  end

# Message Analysis

  def contains?(*word_list)
    # finds if the listed words are in this event's text
    event_text.downcase.split(/\b/).select {|word| word_list.include?(word) }.any?
  end

  def greeting?
    contains? "hello", "hi", "hey"
  end

  def story?
    contains? "story", "tell", "history"
  end

  def advice?
    contains? "advice", "how"
  end

# Message Content

  def greeting_message
    [
      "Nice to meet you, I'm LarryBot",
      "You are a very nice person."
    ].sample
  end

  def story_message
    [
      "Once upon a time I was a tiny bot...",
      "You don't want to hear a story"
    ].sample
  end

  def advice_message
    [
     "get your teeth whitened",
     "take out a second morgage on your boat",
     "don't eat lead"
    ].sample
  end

  def unkown_message
    [
     "Hmmmm....",
     "Ask me to tell you a story",
     "Did you want to ask for advice?",
     "I don't know what you want, speak my language!"
    ].sample
  end

# Respond

  def respond_with(message)
    # use team object to send message with this events channel
    team.send_response(channel, message)
  end

  def message
    # respond with the appropriate message
    if greeting?
      respond_with greeting_message
    elsif story?
      respond_with story_message
    elsif advice?
      respond_with advice_message
    else
      respond_with unkown_message
    end
  end
end