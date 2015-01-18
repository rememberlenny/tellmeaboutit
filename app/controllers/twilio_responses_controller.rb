class TwilioResponsesController < ApplicationController
  def id_number
    id = params[:id]
    response = query_for_id id
    render json: params[:Digit]
  end

  def self.query_for_id id
    if
      # Try again
    else
      # It works
    end
  end
end
