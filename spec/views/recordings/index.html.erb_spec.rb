require 'rails_helper'

RSpec.describe "recordings/index", :type => :view do
  before(:each) do
    assign(:recordings, [
      Recording.create!(
        :url => "Url",
        :length => "Length",
        :transcript => "Transcript",
        :twilio_id => "Twilio"
      ),
      Recording.create!(
        :url => "Url",
        :length => "Length",
        :transcript => "Transcript",
        :twilio_id => "Twilio"
      )
    ])
  end

  it "renders a list of recordings" do
    render
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Length".to_s, :count => 2
    assert_select "tr>td", :text => "Transcript".to_s, :count => 2
    assert_select "tr>td", :text => "Twilio".to_s, :count => 2
  end
end
