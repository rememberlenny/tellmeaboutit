class Textthread < ActiveRecord::Base
  # State: 'current', 'complete'

  def self.twilio_client
    # Pass your twilio account sid and auth token
    @twilio ||= Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_ACCOUNT_TOKEN'])
  end

  def self.twilio_number
    return '+13479831841'
  end

  def self.send_message(target, message)
    from = Textthread.twilio_number
    client = Textthread.twilio_client
    client.messages.create(
      from: from,
      to: target,
      body: message
    )
  end

  def self.start_new_thread user_id, story_id, state, question
    if !Story.find(story_id).nil?

      threads = Textthread.where(story_id: story_id)

      if threads.count == 0
        puts 'New story created'
        thread = Textthread.new( user_id: user_id, story_id: story_id, state: state, last_question: question )
      else
        thread = threads.last
      end

      return thread
    end
    puts 'Story not found'
  end

  def self.find_next_message_on_thread thread_id
    puts 'Ran find_next_message_on_thread thread_id'
    thread  = Textthread.find(thread_id)
    # User the thread state to find out what is next
    action = check_thread_state_action thread.state
  end

  def self.get_thread_by_user_id user_id
    threads = Textthread.where(user_id: user_id)
    if threads.count > 0
      thread = threads.last
    else
      user = User.find(user_id)
      story = user.stories.new(origin: 'from_call')
      thread = Textthread.new(user_id: user_id, story_id: story.id)
      thread.save
    end
    return thread.id
  end

  def self.thread_state(var1 = nil)
    number_to_call = '(347) 983-1841'
    state = {
      :welcome => {
        :state    => 'sent_welcome',
        :message  => 'Welcome to Tell Me \'Bout it, a service to share your breakup stories. To get started, call ' + number_to_call.to_s + ' and share your own story.'
      },
      :reply_before_recording => {
        :state    => 'sent_before_recording_message',
        :message  => 'Try calling in, then we\'ll give you more options'
      },
      :reply_before_recording_again => {
        :state    => 'sent_before_recording_message_again',
        :message  => 'Seriously. Stop sending texts and just call. ' + number_to_call.to_s + '.'
      },
      :response_thank => {
        :state    => 'sent_response_thank',
        :message  => 'Thank you for submitting your recording. You can now view it here: ' + var1 + '.'
      },
      :response_followup => {
        :state    => 'sent_response_followup',
        :message  => 'We would like to ask you for details about your story. Reply YES to continue.'
      }
    }
    return state
  end

end
