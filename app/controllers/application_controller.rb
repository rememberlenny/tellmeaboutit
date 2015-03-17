class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def twilio_client
    # Pass your twilio account sid and auth token
    @twilio ||= Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_ACCOUNT_TOKEN'])
  end

  def twilio_number
    return '+13479831841'
  end

  def send_message(target, message)
    from = twilio_number
    client = twilio_client
    client.messages.create(
      from: twilio_number,
      to: target,
      body: message
    )
  end
end
