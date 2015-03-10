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

end
