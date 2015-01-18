class TwilioResponsesController < ApplicationController

  def say_intro
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/1-welcome.wav</Play>";
    response << "<Gather timeout=\"10\" finishOnKey=\"#\" action=\"http://tellmeaboutit.herokuapp.com/get_id\" method=\"GET\">"
    response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
    response << "</Gather>"
    response << "</Response>";
    render text: response
  end

  def id_number
    id = params[:Digits]
    puts 'id entered: ' + id.to_s
    response = query_for_id id
    render text: response
  end

  def query_for_id id
    account = Account.where(:uid => id)
    puts 'occount: ' + account.to_s
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    if account != nil
      response << "<Record transcribe=\"true\" finishOnKey=\"#\" maxLength=\"45\" transcribeCallback=\"https://tellmeaboutit.herokuapp.com/handle_response\"/>";
      response << "<Gather timeout=\"10\" numDigits=\"1\">"
        response << "<Say>If you are happy with your recording, press pound.</Say>"
        response << "<Say>If you would like to listen to the recording, press 1.</Say>"
        response << "<Say>If you would like to re-record your message, ppress *.</Say>"
      response << "</Gather>"
    else
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
      response << "<Record action=\"https://tellmeaboutit.herokuapp.com/handle_response\" method=\"GET\">";
      response << " <Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
      response << "</Record>";
    end
    response << "</Response>";
    return response
  end
end
