class VoiceexchangeController < ApplicationController
  def base_url
    # return 'http://5a9b7d9f.ngrok.com/'
    return 'http://www.tellmebout.it/'
  end

  def voice_delegate
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_ACCOUNT_TOKEN']
    from = params[:From]
    check_voice_state from
  end

  def check_voice_state from
    thread_state = check_state_from_phone from
    if thread_state == 'recorded_audio'
      ask_to_decide_via_text
    elsif thread_state == 'follow_up' || thread_state == 'sent_more_info' || thread_state == 'sent_thanks'
      ask_to_start_a_new_thread
    else
      start_a_new_thread from
    end
  end

  def ask_to_decide_via_text
    puts 'Doing ask_to_decide_via_text'
    response =  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Say>Please reply to our text message before recording again.</Say>";
    response << "</Response>";
    render text: response
  end

  def start_a_new_thread from
    uid = User.find_user_from_phone from
    puts 'Managing a call from ' + uid.to_s
    say_intro
  end

  def check_state_from_phone from
    uid = User.find_user_from_phone from
    thread_id = Textthread.get_thread_by_user_id uid
    thread = Textthread.find(thread_id)
    return thread.state
  end

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
    puts 'Doing say_intro'
    response =  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << "<Play>" + audio_welcome + "</Play>";
    response << "<Play>" + audio_start_record + "</Play>"
    response << content_for_record
    response << "</Response>";
    render text: response
  end

  def content_for_record
    puts 'Running content_for_record'
    response = "<Record transcribe=\"true\" finishOnKey=\"#\" maxLength=\"120\" method=\"GET\" action=\"" + base_url + "voice/after_recording\"/>";
    return response
  end

  # Get the recording and create Story + Recording
  # - Grab CallSid from TwilioCall
  # - Create an Story
  def after_recording
    puts 'Doing after_recording'
    from = params[:From]
    duration = params['RecordingDuration']
    recording_url = params['RecordingUrl']

    manage_after_recording_actions(from, duration, recording_url)

    response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    response << "<Response>";
    response << "<Play>" + audio_thank + "</Play>" # Go straight to end
    response << "</Response>";

    render text: response
  end

  def manage_after_recording_actions(from, duration, recording_url)
    puts 'Running manage_after_recording_actions'
    uid = User.find_user_from_phone from
    u = User.find(uid)
    puts 'Found user: ' + uid.to_s
    s = u.stories.new(name: 'Unknown')
    s.save
    puts 'Created story: ' + s.id.to_s

    r = s.recordings.new(
      url: recording_url,
      source: 'Call in - ' + duration.to_s
    )
    r.save
    puts 'Create new thread'
    Textthread.start_new_thread(uid, s.id, 'Recording complete', nil)
    puts 'Story.begin_followup_texts'
    Story.begin_followup_texts(uid, s.id, r.id)
  end

  def after_recording_text_message
    return 'Thank you for submitting your story. Please reply to the following questions to add details. [info|edit|stop]'
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

  # def rerecord
  #   response << content_for_record
  #   return response
  # end

  # def check_recording
  #   sid = params[:CallSid]
  #   d = params[:Digits]

  #   puts "We got this " + d

  #   response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
  #   response << "<Response>"
  #   if d == "#"
  #     response << proceed_forward
  #   elsif d == "1"
  #     response << listen_back(sid)
  #     response << provide_options
  #   elsif d == "*"
  #     response << rerecord
  #   end
  #   response << "</Response>"
  #   render text: response
  # end

  # def check_response
  #   response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
  #   response << "<Response>";
  #   response << provide_options
  #   response << "</Response>";
  #   render text: response
  # end

  # def provide_options
  #   response = "<Gather method=\"GET\" action=\"" + base_url + "/check_recording\" numDigits=\"1\">"
  #   response << "<Play>" + audio_options + "</Play>"
  #   response << "</Gather>"
  #   return response
  # end

  # def proceed_forward
  #   response = "<Play>" + audio_thank + "</Play>"
  #   return response
  # end

  # def listen_back sid
  #   call_array = TwilioCall.where(sid: sid)
  #   call = call_array.first
  #   call_id = call.id
  #   recordings = Recording.where(twilio_id: call_id)
  #   recording = recordings.last.url + '.mp3'
  #   response = "<Play>" + recording + "</Play>"
  #   return response
  # end

end
