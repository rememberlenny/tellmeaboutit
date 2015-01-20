class TwilioResponsesController < ApplicationController
  def base_url
    return 'http://tellmebout.it'
  end

  def say_intro
    sid = params[:CallSid]
    from = params[:From]
    fromCity = params[:FromCity]
    fromState = params[:FromState]
    fromZip = params[:FromZip]
    fromCountry = params[:FromCountry]

    call = TwilioCall.create(
      sid:          sid,
      from:         from,
      fromCity:     fromCity,
      fromState:    fromState,
      fromZip:      fromZip,
      fromCountry:  fromCountry,
      )
    call.save

    puts 'twilio_call created id: ' + call.id.to_s

    response =  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/1-welcome.wav</Play>";
    response << gather_id_prompt
    response << "</Response>";

    render text: response
  end

  def check_recording
    # sid = params[:CallSid]
    # call_array = TwilioCall.where(sid: sid)
    # call = call_array.first

    # call_id = call.id

    # d = params[:Digits]

    # puts "We got this " + d

    # response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    # response << "<Response>"
    # if d == "#"
    #   response << proceed_forward
    # elsif d == "1"
    #   response << listen_back call_id
    #   response << provide_options
    # elsif d == "*"
    #   response << rerecord
    # end
    # response << "</Response>"
    # render text: response
  end

  def after_recording
    sid = params['CallSid']
    call_array = TwilioCall.where(sid: sid)
    call = call_array.first

    url = params['RecordingUrl']
    length = params['RecordingDuration']

    recording = Recording.create( url: url, length: length, twilio_id: call.id )

    recording.save

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

  def get_id
    puts 'Ran get_id'
    id = params[:Digits]
    puts 'id entered: ' + id.to_s
    response = query_for_id id
    render text: response
  end


  def provide_options
    response = "<Gather timeout=\"10\" method=\"GET\" action=\"" + base_url + "/check_recording\" numDigits=\"1\">"
    response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/6-options.wav</Play>"
    response << "</Gather>"
    return response
  end

  def proceed_forward
    response = "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/8-beep.wav</Play>"
    return response
  end

  def listen_back call_id
    recordings = Recording.where(twilio_id: call_id)
    recording = recordings.last + '.mp3'
    response = "<Play>" + recording + "</Play>"
    return response
  end

  def rerecord
    response = "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/4-record-again.wav</Play>"
    response << content_for_record
    return response
  end

  def content_for_record
    response = "<Record transcribe=\"true\" finishOnKey=\"#\" maxLength=\"45\" method=\"GET\" action=\"" + base_url + "/after_recording\"/>";
    return response
  end

  def gather_id_prompt
      puts 'Ran gather_id_prompt'
      response =  "<Gather timeout=\"10\" numDigits=\"6\" finishOnKey=\"#\" action=\"" + base_url + "/get_id\" method=\"GET\">"
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
      response << "</Gather>";
      return response
  end

  def query_for_id id
    a = Account.where(uid: id.to_i)
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    if a.first != nil
      puts 'id was matched: ' + id
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/6-begin-speaking.wav</Play>"
      response << content_for_record
    else
      puts 'id did not match'
      response << '<Say>ID did not match. You entered ' + id + '</Say>'
      response << gather_id_prompt
    end
    response << "</Response>";
    return response
  end
end
