require 'rails_helper'

RSpec.describe TextexchangeController, type: :controller do

  describe "GET #welcome" do
    it "returns http success" do
      get :welcome
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #follow_up_questions" do
    it "returns http success" do
      get :follow_up_questions
      expect(response).to have_http_status(:success)
    end
  end


  describe 'find_user_from_phone helper with nil' do
    user = TextexchangeHelper.find_user_from_phone nil
    if user == nil
      assert_response :success
    else
      assert_response :failure
    end
  end

  describe 'find_user_from_phone helper with user' do
    User.delete_all
    u = User.new(phone_number: '+19493228496', :password => 'password123')
    u.save
    user = TextexchangeHelper.find_user_from_phone('+19493228496')
    if user != nil
      assert_response :success
    else
      assert_response :failure
    end
  end

  describe 'check textexchange#text_delegate' do

    assert_response :success
  end


end
