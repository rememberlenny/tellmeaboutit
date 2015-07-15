require 'rails_helper'

RSpec.describe TextexchangeController, type: :controller do

  describe "TextexchangeHelper.find_user_from_phone helper" do
    it "should not return nil for 19493228496" do
      uid = TextexchangeHelper.find_user_from_phone '19493228496'
      expect(uid).to equal(2)
    end
  end


  describe "Text Delegate" do
    it "should not return nil for 19493228496" do
      uid = TextexchangeHelper.find_user_from_phone '19493228496'
      expect(uid).to equal(2)
    end
  end

  # describe 'find_user_from_phone helper with user' do
  #   User.delete_all
  #   u = User.new(phone_number: '+19493228496', :password => 'password123')
  #   u.save
  #   user = TextexchangeHelper.find_user_from_phone('+19493228496')
  #   if user != nil
  #     assert_response :success
  #   else
  #     assert_response :failure
  #   end
  # end

  # describe 'check textexchange#text_delegate' do

  #   assert_response :success
  # end


end
