require 'test_helper'

class TextexchangeControllerTest < ActionController::TestCase

  test 'Test working' do
    assert_response :success
  end

  test 'find_user_from_phone helper' do
    user = TextexchangeHelper.find_user_from_phone nil
    if user == nil
      assert_response :success
    end
  end

  test 'check textexchange#text_delegate' do
    get :text_delegate
    assert_response :success
  end

end
