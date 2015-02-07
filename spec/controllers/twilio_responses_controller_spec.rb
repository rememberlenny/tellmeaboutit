require 'rails_helper'

RSpec.describe TwilioResponsesController, :type => :controller do

  describe "GET id_number" do
    it "returns http success" do
      get :id_number
      expect(response).to have_http_status(:success)
    end
  end

end
