class HandleResponseController < ApplicationController
  def save
    recording = params[:RecordingUrl]
    length = params[:RecordingDuration]
    a = Account.new(:recording_url => recording, :recording_length => length)
    a.save
  end

  private
    def handle_response_params
      params.require(:account).permit(:recording_url, :recording_length, :account_id, :created_at, :updated_at)
    end
end
