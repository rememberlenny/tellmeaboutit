class StaticPagesController < ApplicationController
  def home
    if signed_in?
      redirect_to dash_path
    end
    @audio = Recording.all
  end

  def splash

  end

  def about
  end

  def contact
  end

end
