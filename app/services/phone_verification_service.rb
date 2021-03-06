class PhoneVerificationService
  attr_reader :user

  def initialize(options)
    @user = User.find(options[:user_id])
  end

  def process
    send_sms
  end

  private

  def from
    # Add your twilio phone number (programmable phone number)
    ENV['tma_twilio_number_for_app']
  end

  def to
    # +1 is a country code for USA
    "#{user.phone_number}"
  end

  def body
    "Please reply with this code '#{user.phone_verification_code}' to
    verify your phone number"
  end

  def twilio_client
    # Pass your twilio account sid and auth token
    @twilio ||= Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_ACCOUNT_TOKEN'])
  end

  def send_sms
    Rails.logger.info "SMS: From: #{from} To: #{to} Body: \"#{body}\""

    twilio_client.account.messages.create(
      from: from,
      to: to,
      body: body
    )
  end
end
