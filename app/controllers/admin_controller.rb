class AdminController < ApplicationController
  def dash
    @stories = Story.all
    @recordings = Recording.all
  end
end
