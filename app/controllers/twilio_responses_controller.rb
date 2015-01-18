class TwilioResponsesController < ApplicationController
  def id_number
    id = params[:id]
    render json: params[:Digit]
  end
end
