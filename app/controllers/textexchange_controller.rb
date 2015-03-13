class TextexchangeController < ApplicationController
  def welcome_response
    'THIS IS A WELCOME. CALL ME TO RECORD!'
  end

  def follow_up_response
    'THIS IS A FOLLOW UP. SEND ME PROMPTS!'
  end

  def text_delegate
    from = params[:From]
    from = from.sub! '+1', ''
    us = User.find(where: params[:From])
    u = us.first
    s = u.stories.last
    r = s.recordings.last
    uid = u.id
    sid = s.id
    rid = r.id
    puts from

    if from
      u = User.where( phone_number: from )

      if u.count > 0
        user = u.first
        threads = Textthread.where(user_id: user.id)
        threads = threads[0]
        if threads.count == 0 || threads.last.state != 'Current'
          # First time. Find out content
          option = Story.find_question_to_ask
          send_message(u.phone_number, option.question)
        elsif welcome threads.count != 0 && threads.last.state == 'Current' #response response
          # Response
          # 1. Respond to result
          response_body = params[:Body]
          option = Story.find_question_to_ask
          threads.last_question
          user[]
          self.begin_followup_texts(uid, sid, rid)
        elsif

        end
      else
        welcome
      end
    end
  end

  def welcome
    User.new(phone_number: params[:From])
    send_message(params[:From], welcome_response)
  end

  def follow_up_questions
    send_message(params[:From], follow_up_response)
  end
end
