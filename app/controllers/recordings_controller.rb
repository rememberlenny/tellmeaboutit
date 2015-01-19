class RecordingsController < ApplicationController
  before_action :set_recording, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @recordings = Recording.all
    respond_with(@recordings)
  end

  def show
    respond_with(@recording)
  end

  def new
    @recording = Recording.new
    respond_with(@recording)
  end

  def edit
  end

  def create
    @recording = Recording.new(recording_params)
    @recording.save
    respond_with(@recording)
  end

  def update
    @recording.update(recording_params)
    respond_with(@recording)
  end

  def destroy
    @recording.destroy
    respond_with(@recording)
  end

  private
    def set_recording
      @recording = Recording.find(params[:id])
    end

    def recording_params
      params.require(:recording).permit(:url, :length, :transcript, :twilio_id)
    end
end
