class Textthread < ActiveRecord::Base
  # State: 'current', 'complete'

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

  def self.thread_state
    number_to_call = twilio_number
    uid = 'NEED_ID'
    state = {
      :welcome      => {
        :state    => 'sent_welcome',
        :message  => 'Welcome to Tell Me \'Bout it, a service to share your breakup stories.'
      },
      :ask_to_call  => {
        :state    => 'sent_request_to_call',
        :message  => 'To get started, call #{number_to_call} and share your own story'
      },
      :follow_up    => {
        :state    => 'sent_follow_up',
        :message  => 'Please answer the following questions by replying your answer. To stop, __do this__'
      },
      :more_info    => {
        :state    => 'sent_more_info',
        :message  => 'To edit or review your submission, please go to http://tellmebout.it/#{uid}'
      },
      :thank        => {
        :state    => 'sent_thanks',
        :message  => 'Thank you for sharing your story!'
      },
    }
    return state
  end

end
