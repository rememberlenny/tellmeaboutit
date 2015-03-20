module TextexchangeHelper

  def self.find_user_from_phone phone_number
    phone_number = phone_number.gsub('+', '')
    users = User.where(:phone_number => phone_number)
    if users.count > 1
      user = users.first
      uid = user.id
    else
      uid = create_user_with_number phone_number
    end
    return uid
  end

  def self.create_user_with_number phone_number
    puts 'Create user with number'
    user = User.new(:phone_number => phone_number, :password => '123')
    user.save
    return user.id
  end

end
