require 'test_helper'

class TextexchangeControllerTest < ActionController::TestCase

  test 'should get welcome_response' do
    get :welcome_response
    assert_response :success
  end

end
