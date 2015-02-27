class StoriesController < ApplicationController
  before_action :require_login, :require_verification

  def dashboard
    if signed_in?
      @stories = current_user.stories
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @story = current_user.stories.find(params[:id])
    @recordings = @story.recordings
  end

  def new
    @story = current_user.stories.build
  end

  def edit
    @story = Story.find(params[:id])
  end

  def create
    @story = current_user.stories.build(story_params)
    if @story.save
      flash[:success] = "story created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def require_verification
      unless current_user.phone_verified?
        flash[:error] = "Your account must be verified to access this section"
        redirect_to verify_path # halts request cycle
      end
    end

    def require_login
      unless signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path # halts request cycle
      end
    end

    def story_params
      params.require(:story).permit(
        :name, :gender, :age, :location,
        :selected_recording_id, :breakup_role,
        :pullquote, :breakup_type, :user_id)
    end
end
