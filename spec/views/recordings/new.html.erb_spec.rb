require 'rails_helper'

RSpec.describe "recordings/new", :type => :view do
  before(:each) do
    assign(:recording, Recording.new(
      :url => "MyString",
      :length => "MyString",
      :transcript => "MyString",
      :twilio_id => "MyString"
    ))
  end

  it "renders new recording form" do
    render

    assert_select "form[action=?][method=?]", recordings_path, "post" do

      assert_select "input#recording_url[name=?]", "recording[url]"

      assert_select "input#recording_length[name=?]", "recording[length]"

      assert_select "input#recording_transcript[name=?]", "recording[transcript]"

      assert_select "input#recording_twilio_id[name=?]", "recording[twilio_id]"
    end
  end
end
