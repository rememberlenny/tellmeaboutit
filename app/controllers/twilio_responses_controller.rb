class TwilioResponsesController < ApplicationController
  def id_number
    id = params[:id]
    response = query_for_id id
    render json: params[:Digit]
  end

  def self.query_for_id id
    account = Accounts.where(:uid => id)
    if account != nil
      # It works
    else
      # Try again
    end
  end
end
