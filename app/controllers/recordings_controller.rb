class RecordingsController < ApplicationController
  before_action :require_login

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
    @story = current_user.stories.find(params[:story_id])
    @recording = @story.recordings.find(params[:id])
  end

  private

    def require_login
      unless signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path # halts request cycle
      end
    end

    def recording_params
      params.require(:recording).permit(:source, :url)
    end
end
