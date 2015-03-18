require 'test_helper'

class TextexchangeControllerTest < ActionController::TestCase

  test 'Test working' do
    assert_response :success
  end

  test 'check textexchange#text_delegate' do
    get :text_delegate
    assert_response :success
  end

end
