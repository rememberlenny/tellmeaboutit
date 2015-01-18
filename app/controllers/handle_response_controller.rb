class HandleResponseController < ApplicationController
  def save
    recording = params[:RecordingUrl]
    length = params[:RecordingDuration]
    a = Account.new(:recording_url => recording, :recording_length => length)
    a.save
    response = double_check
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
