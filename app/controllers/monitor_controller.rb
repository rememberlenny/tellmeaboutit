class MonitorController < ApplicationController
  def dashboard
    @user_count =       User.count
    @text_count =       Textthread.count
    @recording_count =  Recording.count
    @voice_count =      Story.count
    @recent = Textthread.all.limit(5).reverse
  end
end
