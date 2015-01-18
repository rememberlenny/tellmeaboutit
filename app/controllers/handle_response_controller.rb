class HandleResponseController < ApplicationController
  def save
    recording = params[:RecordingUrl]
    length = params[:RecordingDuration]
    a = Account.new(:recording_url => recording, :recording_length => length)
    a.save
  end
end
