require 'rails_helper'

RSpec.describe "recordings/show", :type => :view do
  before(:each) do
    @recording = assign(:recording, Recording.create!(
      :url => "Url",
      :length => "Length",
      :transcript => "Transcript",
      :twilio_id => "Twilio"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Length/)
    expect(rendered).to match(/Transcript/)
    expect(rendered).to match(/Twilio/)
  end
end
