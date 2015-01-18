class TwilioResponsesController < ApplicationController

  def id_number
    id = params[:id]
    response = query_for_id id
    render text: response
  end

  def query_for_id id
    account = Account.where(:uid => id)
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    if account != nil
      response << "<Record transcribe=\"true\" finishOnKey=\"#\" maxLength=\"45\" transcribeCallback=\"https://tellmeaboutit.herokuapp.com/handle_response\"/>";
    else
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
      response << "<Gather action=\"https://tellmeaboutit.herokuapp.com/getid\" method=\"GET\">";
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
      response << "</Gather>";
    end
    response << "</Response>";
    return response
  end
end
