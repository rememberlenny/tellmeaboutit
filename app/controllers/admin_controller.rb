class AdminController < ApplicationController
  def dash
    @stories = Story.all
    @recordings = Recording.all
    @twiliocalls = TwilioCall.all
    @accounts = Account.all
  end
end
