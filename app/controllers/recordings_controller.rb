class RecordingsController < ApplicationController
  def new
    @story = current_user.stories.find(params[:story_id])
    @recording = @story.recordings.build
  end

  def create
    @story = current_user.stories.find(params[:story_id])
    @recording = @story.recordings.build(recording_params)
    if @recording.save
      flash[:success] = "recording created!"
      redirect_to story_url(@story)
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def show
  end

  private
    def recording_params
      params.require(:recording).permit(:source, :url)
    end
end
