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
      params.require(:story).permit(:content)
    end
end
