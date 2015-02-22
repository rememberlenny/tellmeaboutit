class StoriesController < ApplicationController
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

    def story_params
      params.require(:story).permit(
        :name, :gender, :age, :location,
        :selected_recording_id, :breakup_role,
        :pullquote, :breakup_type, :user_id)
    end
end
