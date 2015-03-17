class TextexchangeController < ApplicationController
  # Receives all the sms and finds the user/creates
  def text_delegate
    from = params[:From]
    uid = User.find_user_from_phone from
    check_conversation_state uid
  end

  # Gets the textthread associated to the user/creates
  def check_conversation_state uid
    # Check for existing thread
    threads = Textthread.where(user_id: uid)
    if threads.count > 0
      thread = threads.last
      thread_id = thread.id
    else
      thread_id = create_thread(uid)
    end
    identify_next_message(thread_id)
  end

  # If no thread exists, create one associated to user
  def create_thread uid
    thread = Textthread.new(user_id: uid)
    thread.save
    return thread.id
  end

  # Find the message the user needs from thread
  def identify_next_message thread_id
    action = get_sms_action thread_id
    change_thread_state( action[:state], thread_id )
    send_action_sms( action[:message], thread_id )
  end

  def get_sms_action thread_id
    thread = Textthread.find(thread_id)

    if thread.story_id == nil
      action = create_story_with_thread thread_id
    else
      action = find_next_message_on_thread thread_id
    end

    return action
  end

  def get_phone_with_thread thread_id
    thread  = Textthread.find(thread_id)
    user    = User.find(thread.user_id)
    return user.phone_number
  end

  def send_action_sms action, thread_id
    phone = get_phone_with_thread(thread_id)
    send_message(phone, action)
  end

  def create_story_with_thread thread_id
    thread  = Textthread.find(thread_id)
    user_id = thread.user_id
    user    = User.find(user_id)
    story   = user.stories.new(origin: 'sms_thread')
    story.save
    options = Textthread.thread_state
    return options[:welcome]
  end

  def find_next_message_on_thread thread_id
    thread  = Textthread.find(thread_id)
    # User the thread state to find out what is next
    action = check_thread_state_action thread.state
  end

  def check_thread_state_action state
    options = Textthread.thread_state
    return options[:state]
  end

  def change_thread_state new_state thread_id
    thread  = Textthread.find(thread_id)
    thread.state = new_state
    thread.exchange_count = thread.exchange_count + 1
    thread.save
  end

  def follow_up_questions
    send_message(params[:From], follow_up_response)
  end
end
