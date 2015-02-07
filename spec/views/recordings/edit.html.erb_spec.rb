require 'rails_helper'

RSpec.describe "recordings/edit", :type => :view do
  before(:each) do
    @recording = assign(:recording, Recording.create!(
      :url => "MyString",
      :length => "MyString",
      :transcript => "MyString",
      :twilio_id => "MyString"
    ))
  end

  it "renders the edit recording form" do
    render

    assert_select "form[action=?][method=?]", recording_path(@recording), "post" do

      assert_select "input#recording_url[name=?]", "recording[url]"

      assert_select "input#recording_length[name=?]", "recording[length]"

      assert_select "input#recording_transcript[name=?]", "recording[transcript]"

      assert_select "input#recording_twilio_id[name=?]", "recording[twilio_id]"
    end
  end
end
