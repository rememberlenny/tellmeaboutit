class AdminController < ApplicationController
  def dash
    @stories = Stories.all
    @recordings = Recordings.all
  end
end
