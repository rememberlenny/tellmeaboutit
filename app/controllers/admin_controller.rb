class AdminController < ApplicationController
  def dash
    @stories = Story.all
    @recordings = Recording.all
    @twiliocalls = TwilioCall.all
  end
end
