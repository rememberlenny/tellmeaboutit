class HandleResponseController < ApplicationController
  def save
    recording = params[:RecordingUrl]
    length = params[:RecordingDuration]
    a = Account.new(:recording_url => recording, :recording_length => length)
    a.save
    response = double_check
    render text: response
  end

  def check_response
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << "<Gather timeout=\"10\" action=\"https://tellmeaboutit.herokuapp.com/check_recording\" numDigits=\"1\">"
    response << "<Say>If you are happy with your recording, press pound.</Say>"
    response << "<Say>If you would like to listen to the recording, press 1.</Say>"
    response << "<Say>If you would like to re-record your message, ppress *.</Say>"
    response << "</Gather>"
    response << "</Response>";
    render text: response
  end

  def double_check
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << "<Say>This works!</Say>";
    response << "</Response>";
    return response
  end
end
