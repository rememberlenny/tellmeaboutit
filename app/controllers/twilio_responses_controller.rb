class TwilioResponsesController < ApplicationController
  def base_url
    return ENV['TMAI_URL']
  end

  def save
    recording = params[:RecordingUrl]
    length = params[:RecordingDuration]
    a = Account.new(:recording_url => recording, :recording_length => length)
    a.save
    response = double_check
    render text: response
  end

  def double_check
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << "<Say>This works!</Say>";
    response << "</Response>";
    return response
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
    sid = params[:CallSid]
    d = params[:Digits]

    puts "We got this " + d

    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    response << "<Response>"
    if d == "#"
      response << proceed_forward
    elsif d == "1"
      response << listen_back(sid)
      response << provide_options
    elsif d == "*"
      response << rerecord
    end
    response << "</Response>"
    render text: response
  end

  def after_recording
    sid = params['CallSid']
    call_array = TwilioCall.where(sid: sid)
    call = call_array.first

    accounts = Account.where(uid: id.to_i)
    a = accounts.first

    story_array = Story.where(account_id: a.id)
    story = story_array.first

    url = params['RecordingUrl']
    length = params['RecordingDuration']

    recording = Recording.create( url: url, length: length, twilio_id: call.id, story_id: story.id )
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
    response = "<Gather method=\"GET\" action=\"" + base_url + "/check_recording\" numDigits=\"1\">"
    response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/6-options.wav</Play>"
    response << "</Gather>"
    return response
  end

  def proceed_forward
    response = "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/8-beep.wav</Play>"
    return response
  end

  def listen_back sid
    call_array = TwilioCall.where(sid: sid)
    call = call_array.first
    call_id = call.twilio_call_id
    recordings = Recording.where(twilio_id: call_id)
    recording = recordings.last.url + '.mp3'
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
    response =  "<Gather  method=\"GET\" numDigits=\"6\" action=\"" + base_url + "/get_id\">";
    response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/3-please-enter-your-id.wav</Play>";
    response << "</Gather>";
    return response
  end

  def query_for_id id
    puts 'query_for_id received: ' + id.to_s
    call_array = TwilioCall.where(sid: params[:CallSid])
    call = call_array.first
    accounts = Account.where(uid: id.to_i)
    a = accounts.first
    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    if a != nil
      a.twilio_call_id = call.id
      a.save
      Story.create(account_id: a.id)
      puts 'id was matched: ' + id.to_s
      response << "<Play>https://s3-us-west-1.amazonaws.com/tellmeabout/6-begin-speaking.wav</Play>"
      response << content_for_record
    else
      puts 'id did not match'
      response << '<Say>ID did not match. You entered ' + id.to_s + '</Say>'
      response << gather_id_prompt
    end
    response << "</Response>";
    return response
  end
end
