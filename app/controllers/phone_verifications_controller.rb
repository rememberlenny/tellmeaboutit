class PhoneVerificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def verify_from_message
    user = get_user_for_phone_verification
    user.mark_phone_as_verified! if user

    render nothing: true
  end

  def resend_verification
    Rails.logger.info Time.now + ": resend_verification triggered"
    PhoneVerificationService.send_sms
  end

  def verify
    if current_user == nil
      redirect_to root_path
    else
      if current_user.phone_verified
        redirect_to root_path
      end
    end
  end

  private

  def get_user_for_phone_verification
    phone_verification_code = params['Body'].try(:strip)
    phone_number            = params['From'].gsub('', '')

    condition = { phone_verification_code: phone_verification_code,
                  phone_number: phone_number }

    User.unverified_phones.where(condition).first
  end
end
