class TextexchangeController < ApplicationController
  def text_delegate
    from = params[:From]
    user = User.find_user_from_phone from
    uid  = user.id
    check_conversation_state uid
  end

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

  def create_thread uid
    thread = Textthread.new(user_id: uid)
    thread.save
    return thread.id
  end

  def identify_next_message thread_id
    thread = Textthread.find(thread_id)

    # first message
    if thread.story_id == nil
      create_story_with_thread thread_id
    # next message
    elsif

    # no more messages
    else

    end
  end

  def create_story_with_thread thread_id
    thread  = Textthread.find(thread_id)
    user_id = thread.user_id
    user    = User.find(user_id)
    user.stories.new(origin: 'sms_thread')
  end

  def welcome
    User.new(phone_number: params[:From])
    send_message(params[:From], welcome_response)
  end

  def follow_up_questions
    send_message(params[:From], follow_up_response)
  end
end
