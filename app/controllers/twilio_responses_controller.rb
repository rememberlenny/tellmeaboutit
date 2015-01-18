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

  def proceed_forward
    response = "<Say>Thank you!</Say>"
  end

  def listen_back
    response = "<Say>Listen again!</Say>"
  end

  def rerecord
    response = "<Say>Do you want to rerecord?</Say>"
  end

  def check_recording
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    d = params[:Digits]
    if d == "#"
      response << proceed_forward
    elsif d == "1"
      response << listen_back
    elsif d == "*"
      response << rerecord
    end
    response << "</Response>";
    render text: response
  end

  def query_for_id id
    account = Account.where(:uid => id)
    puts 'occount: ' + account.to_s
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    if account != nil
      response << "<Record transcribe=\"true\" finishOnKey=\"#\" maxLength=\"45\" method=\"GET\" action=\"https://tellmeaboutit.herokuapp.com/check_recording\"/>";
    # else
    #   response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
    #   response << "<Record action=\"https://tellmeaboutit.herokuapp.com/handle_response\" method=\"GET\">";
    #   response << " <Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
    #   response << "</Record>";
    end
    response << "</Response>";
    return response
  end
end
