require 'rails_helper'

RSpec.describe VoiceexchangeController, type: :controller do

  describe "VoiceexchangeController.voice_delegate" do
    params = {
      "AccountSid"=>"ACb9f7fef2fed34f1092fd1ceac6b5212a",
      "ToZip"=>"10307",
      "FromState"=>"CA",
      "Called"=>"+13479831841",
      "FromCountry"=>"US",
      "CallerCountry"=>"US",
      "CalledZip"=>"10307",
      "Direction"=>"inbound",
      "FromCity"=>"LAKE FOREST",
      "CalledCountry"=>"US",
      "CallerState"=>"CA",
      "CallSid"=>"CA5749782a8113801c8457db3a1a12498c",
      "CalledState"=>"NY",
      "From"=>"+19493228496",
      "CallerZip"=>"92692",
      "FromZip"=>"92692",
      "CallStatus"=>"ringing",
      "ToCity"=>"STATEN ISLAND",
      "ToState"=>"NY",
      "To"=>"+13479831841",
      "ToCountry"=>"US",
      "CallerCity"=>"LAKE FOREST",
      "ApiVersion"=>"2010-04-01",
      "Caller"=>"+19493228496",
      "CalledCity"=>"STATEN ISLAND"
    }
    it "should have params" do
      expect(params[:From]).to equal(params[:From])
    end
    it "should have handle existing phone" do
      expect(params[:From]).to equal(params[:From])
    end
  end

end
