class TextexchangeController < ApplicationController
  def welcome_response
    'THIS IS A WELCOME. CALL ME TO RECORD!'
  end

  def follow_up_response
    'THIS IS A FOLLOW UP. SEND ME PROMPTS!'
  end

  def text_delegate
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_ACCOUNT_TOKEN']
    u = User.where( :phone_number => params[:From] )
    if u.count > 0
      user = u.first
      if user.stories.count == 0
        welcome @client
      elsif user.stories > 0
        follow_up_questions @client
      end
    end
  end

  def welcome @client
    if params[:From]
      @client.messages.create(
        from: '+13479831841',
        to: params[:From],
        body: welcome_response
      )
    end
  end

  def follow_up_questions
    if params[:From]
      @client.messages.create(
        from: '+13479831841',
        to: params[:From],
        body: follow_up_response
      )
    end
  end
end
