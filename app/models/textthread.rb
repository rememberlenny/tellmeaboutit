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

end
