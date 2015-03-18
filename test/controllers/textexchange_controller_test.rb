require 'test_helper'

class TextexchangeControllerTest < ActionController::TestCase

  test 'Test working' do
    assert_response :success
  end

  test 'find_user_from_phone helper with nil' do
    user = TextexchangeHelper.find_user_from_phone nil
    if user == nil
      assert_response :success
    else
      assert_response :failure
    end
  end

  test 'find_user_from_phone helper with user' do
    User.delete_all
    u = User.new(phone_number: '+19493228496', :password => 'password123')
    u.save
    user = TextexchangeHelper.find_user_from_phone('+19493228496')
    if user != nil
      assert_response :success
      assert_response :success
    else
      assert_response :failure
    end
  end

  test 'check textexchange#text_delegate' do

    assert_response :success
  end

end
