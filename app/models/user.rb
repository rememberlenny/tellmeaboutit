class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:phone_number]
  has_many :stories, dependent: :destroy

  # scope :unverified_phones,  -> { where(phone_verified: false) }
  # before_save :set_phone_attributes, if: :phone_verification_needed?
  # after_save :send_sms_for_phone_verification, if: :phone_verification_needed?

  def self.find_user_from_phone from
    users = User.where(phone_number: from)
    if users.count > 0
      user = users.first
      puts 'users.count > 0 Grab the user: ' + user.id.to_s
    else
      user = User.new(phone_number: from, password: '123123123')
      user.save
      puts 'else Grab the user: ' + user.id.to_s
    end
    return user.id
  end

  def mark_phone_as_verified!
    update!(phone_verified: true, phone_verification_code: false)
  end

  def email_required?
    return false
  end

  private

  def set_phone_attributes
    self.phone_verified = false
    self.phone_verification_code = generate_phone_verification_code

    # removes all white spaces, hyphens, and parenthesis
    self.phone_number.gsub!(/[\s\-\(\)]+/, '')
  end

  def send_sms_for_phone_verification
    PhoneVerificationService.new(user_id: id).process
  end

  def generate_phone_verification_code
    begin
      verification_code = Random.rand(100000...999999)
    end while self.class.exists?(phone_verification_code: verification_code)

    verification_code
  end

  def phone_verification_needed?
    phone_number.present? && phone_number_changed?
  end
end
