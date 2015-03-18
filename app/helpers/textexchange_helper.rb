module TextexchangeHelper

  def self.find_user_from_phone phone_number
    users = User.where(:phone_number => phone_number)
    if users.count > 0
      user = user.first
    else
      user = nil
    end
    return user
  end

end
