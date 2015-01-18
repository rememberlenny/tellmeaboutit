class TwilioResponsesController < ApplicationController
  def id_number
    id = params[:id]
    response = query_for_id id
    render json: params[:Digit]
  end

  def self.query_for_id id
    account = Accounts.where(:uid => id)
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    if account != nil
      response << "<Response>";
      response << "<Record transcribe=\"true\"  timeout=\"45\" transcribeCallback=\"https://tellmeaboutit.herokuapp.com/handle_response\"/>";
      response << "</Response>";
      # It works
    else
      response << "<Response>"
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
      response << "<Gather action=\"https://tellmeaboutit.herokuapp.com/getid\" method=\"GET\">";
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
      response << "</Gather>";
      response << "</Response>";
    end
  end
end
