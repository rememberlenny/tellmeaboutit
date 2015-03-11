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
    puts from
    if from
      u = User.where( phone_number: from )
      if u.count > 0
        user = u.first
        if user.stories.count == 0

        elsif user.stories.count > 0
          follow_up_questions
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
