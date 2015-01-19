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

  def check_recording
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    d = params[:Digits]
    puts "###############"
    puts "We got this " + d
    if d == "#"
      response << proceed_forward
    elsif d == "1"
      response << listen_back
      response << provide_options
    elsif d == "*"
      response << rerecord
    end
    response << "</Response>";
    render text: response
  end

  def after_recording
    sid = params['CallSid']
    url = params['RecordingUrl']
    length = params['RecordingDuration']
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << provide_options
    response << "</Response>";
    render text: response
  end

  def check_response
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << provide_options
    response << "</Response>";
    render text: response
  end

  def id_number
    id = params[:Digits]
    puts 'id entered: ' + id.to_s
    response = query_for_id id
    render text: response
  end


  def provide_options
    response = "<Gather timeout=\"10\" method=\"POST\" action=\"https://tellmeaboutit.herokuapp.com/check_recording\" numDigits=\"1\">"
    response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/6-options.wav</Play>"
    response << "</Gather>"
    return response
  end

  def proceed_forward
    response = "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/8-beep.wav</Play>"
    return response
  end

  def listen_back
    recording = params[:recording_url] + '.mp3'
    response = "<Play>" + recording + "</Play>"
    return response
  end

  def rerecord
    response = "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/4-record-again.wav</Play>"
    response << content_for_record
    return response
  end

  def content_for_record
    response = "<Record transcribe=\"true\" finishOnKey=\"#\" maxLength=\"45\" method=\"GET\" action=\"https://tellmeaboutit.herokuapp.com/after_recording\"/>";
    return response
  end

  def query_for_id id
    account = Account.where(:uid => id)
    puts 'occount: ' + account.to_s
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    # if account != nil
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/6-begin-speaking.wav</Play>"
      response << content_for_record
    # else
    #   response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
    #   response << "<Record action=\"https://tellmeaboutit.herokuapp.com/handle_response\" method=\"GET\">";
    #   response << " <Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
    #   response << "</Record>";
    # end
    response << "</Response>";
    return response
  end
end
