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


  def self.get_user_with_thread thread_id
    puts 'Ran get_user_with_thread thread_id'
    thread  = Textthread.find(thread_id)
    puts 'get_user_with_thread found thread_id: ' + thread_id.to_s
    user_id = thread.user_id
    puts 'get_user_with_thread found user_id: ' + user_id.to_s
    user    = User.find(user_id)
    return user
  end

  def self.find_user_from_phone from
    users = User.where(phone_number: from)
    if users.count > 0
      user = users.first
      puts 'users.count > 0 Grab the user: ' + user.id.to_s
    else
      password = verification_code = Random.rand(100000...999999)
      user = User.new(phone_number: from, password: password)
      User.send_welcome_text(from, password)
      user.save
      puts 'else Grab the user: ' + user.id.to_s
    end
    return user.id
  end

  def self.send_welcome_text(from, password)
    message = 'Welcome to Tell Me Bout It. To login, go to http://tellmebout.it/login Your user name is: ' + from + ' Your password is: ' + password + ''
    Textthread.send_message(from, message)
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
