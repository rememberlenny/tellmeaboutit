class StaticPagesController < ApplicationController
  def home
    @story = current_user.stories.build
  end

  def about
  end

  def contact
  end

end
