class TwilioResponsesController < ApplicationController

  # Relevant audio files

  # Order of actions
  # 1. Call and return prompt
  # 2. Record and Accept key to end
  # 3. Accept key to rerecord/listen/proceed
  # 4. Play prompt

  # Initialize the TwilioCall
  # - Need recording
  # - Need story
  def say_intro
   call = TwilioCall.create(
      sid:          params[:CallSid],
      from:         params[:From],
      fromCity:     params[:FromCity],
      fromState:    params[:FromState],
      fromZip:      params[:FromZip],
      fromCountry:  params[:FromCountry],
    )
    call.save
    puts 'twilio_call created id: ' + call.id.to_s
    response =  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << "<Play>" + audio_welcome + "</Play>";
    response << "<Play>" + audio_start_record + "</Play>"
    response << content_for_record
    response << "</Response>";
    render text: response
  end

  # Get the recording and create Story + Recording
  # - Grab CallSid from TwilioCall
  # - Create an Story
  def after_recording
    TwilioCall.where(sid: params['CallSid'])

    accounts = Account.where(twilio_call_id: call.id.to_i)
    a = accounts.first

    story_array = Story.where(account_id: a.id)
    story = story_array.first

    url = params['RecordingUrl']
    length = params['RecordingDuration']

    recording = Recording.create( url: url, length: length, twilio_id: call.id, story_id: story.id, sid: params['RecordingSid'] )
    recording.save

    story.recording_id = recording.id
    story.save

    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response = "<Play>" + audio_thank + "</Play>"
    # response << provide_options
    response << "</Response>";
    render text: response
  end


  def content_for_record
    response = "<Record transcribe=\"true\" finishOnKey=\"#\" maxLength=\"45\" method=\"GET\" action=\"" + base_url + "/after_recording\"/>";
    return response
  end

  def rerecord
    response << content_for_record
    return response
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
    response << "<Play>" + audio_options + "</Play>"
    response << "</Gather>"
    return response
  end

  def proceed_forward
    response = "<Play>" + audio_thank + "</Play>"
    return response
  end

  def listen_back sid
    call_array = TwilioCall.where(sid: sid)
    call = call_array.first
    call_id = call.id
    recordings = Recording.where(twilio_id: call_id)
    recording = recordings.last.url + '.mp3'
    response = "<Play>" + recording + "</Play>"
    return response
  end

  def audio_welcome
    return 'http://lamivo.com/quantifiedbreakup/tellmeboutit/welcome.mp3'
  end

  def audio_start_record
    return 'http://lamivo.com/quantifiedbreakup/tellmeboutit/begin-speaking.mp3 '
  end

  def audio_thank
    return 'http://lamivo.com/quantifiedbreakup/tellmeboutit/goodbye-hangup.mp3'
  end

  def audio_options
    return 'http://lamivo.com/quantifiedbreakup/tellmeboutit/if-youre-happy.mp3'
  end

  def base_url
    return ENV['TMAI_URL']
  end

end
