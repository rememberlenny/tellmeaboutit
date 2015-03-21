module TextexchangeHelper

  def self.find_user_from_phone phone_number
    puts 'Run self.find_user_from_phone phone_number'
    puts 'phone_number is: ' + phone_number.to_s
    phone_number = phone_number.gsub('+', '')
    users = User.where(:phone_number => phone_number)
    puts 'Users is: ' + users.to_s
    if users.count > 0
      user = users.first
      puts 'Selected user: ' + user.id.to_s
      uid = user.id
    else
      uid = create_user_with_number phone_number
    end
    puts 'Returning uid: ' + uid.to_s
    return uid
  end

  def self.create_user_with_number phone_number
    puts 'Create user with number'
    user = User.new(:phone_number => phone_number, :password => '123123123')
    user.save
    return user.id
  end

end
