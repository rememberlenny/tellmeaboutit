class TextexchangeController < ApplicationController
  # Receives all the sms and finds the user/creates
  def text_delegate
    puts 'Ran text_delegate'
    from = params[:From]
    puts 'Got ' + from
    uid = TextexchangeHelper.find_user_from_phone from
    puts 'UID is ' + uid.to_s + '.'
    check_conversation_state(uid)
    render text: ''
  end

  # Gets the textthread associated to the user/creates
  def check_conversation_state uid
    puts 'Ran check_conversation_state uid'
    puts 'Ran check_conversation_state uid: ' + uid.to_s
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
    puts 'Ran create_thread uid'
    thread = Textthread.new(user_id: uid)
    thread.save
    return thread.id
  end

  # Find the message the user needs from thread
  def identify_next_message thread_id
    puts 'Ran identify_next_message thread_id'
    action = get_sms_action thread_id
    change_thread_state( action, thread_id )
  end

  def get_sms_action thread_id
    puts 'Ran get_sms_action thread_id'
    thread = Textthread.find(thread_id)
    if thread.story_id == nil
      action = Story.create_story_with_thread thread_id
    else
      action = Textthread.find_next_message_on_thread thread_id
    end
    return action
  end

  def get_phone_with_thread thread_id
    puts 'Ran get_phone_with_thread thread_id'
    thread  = Textthread.find(thread_id)
    user    = User.find(thread.user_id)
    return user.phone_number
  end

  def get_user_with_thread thread_id
    puts 'Ran get_user_with_thread thread_id'
    thread  = Textthread.find(thread_id)
    puts 'get_user_with_thread found thread_id: ' + thread_id.to_s
    user_id = thread.user_id
    puts 'get_user_with_thread found user_id: ' + user_id.to_s
    user    = User.find(user_id)
    return user
  end

  def send_action_sms action, thread_id
    puts 'Ran send_action_sms action, thread_id'
    phone = get_phone_with_thread(thread_id)
    send_message(phone, action)
  end

  def check_thread_state_action state
    puts 'Ran check_thread_state_action state'
    options = Textthread.thread_state
    return options[:state]
  end

  def change_thread_state action, thread_id
    puts 'Ran change_thread_state new_state, thread_id'

    state_object = Textthread.thread_state
    thread  = Textthread.find(thread_id)
    if thread.state == 'sent_welcome' && thread.exchange_count == 1
      action = state_object[:reply_before_recording]
    elsif thread.state == 'sent_before_recording_message' && thread.exchange_count == 1
      action = state_object[:reply_before_recording_again]
    else
      if thread.exchange_count == nil
        thread.exchange_count = 1
      else
        thread.exchange_count = thread.exchange_count + 1
      end
    end
    puts 'thread.exchange_count is: ' + thread.exchange_count.to_s
    thread.state = action[:state]
    thread.save

    send_action_sms( action[:message], thread_id )
  end
end
