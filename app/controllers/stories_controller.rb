class StoriesController < ApplicationController
  before_action :require_login, :require_verification
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def dashboard
    if signed_in?
      @stories = current_user.stories
    else
      redirect_to new_user_session_path
    end
  end

  def index
    @stories = current_user.stories.all
    respond_with(@stories)
  end

  def show
    @story = current_user.stories.find(params[:id])
    @recordings = @story.recordings
    respond_with(@story)
  end

  def new
    @story = current_user.stories.build
    respond_with(@story)
  end

  def edit
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

  def update
    @story.update(story_params)
    respond_with(@story)
  end

  def destroy
    @story.destroy
    respond_with(@story)
  end

  private
    def set_story

      @story = Story.find(params[:id])
    end

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
