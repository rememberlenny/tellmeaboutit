class AdminController < ApplicationController
  def dash
    @hash = full_accounts
  end

  def index
    @hash = full_accounts
    render json: @hash
  end

  def full_accounts
    @hash = []

    accounts = Account.all

    accounts.each do |account|
      if account.twilio_call_id != nil
        call = TwilioCall.find(account.twilio_call_id)
        a = {}
        account_id = account.id
        a[:id] = account.id
        a[:uid] = account.uid
        a[:created_at] = account.created_at
        a[:fromCity] = call.fromCity
        a[:fromZip] = call.fromZip
        a[:fromCountry] = call.fromCountry
        a[:fromState] = call.fromState
        a[:stories] = full_stories account_id
        @hash << a
      end
    end
    return @hash
  end

  def full_stories account_id
    stories_obj = []
    stories = Story.where(account_id: account_id)
    recordings = []
    stories.each do |story|
      s = {}
      s[:id] = story.id
      s[:was_checked] = story.was_checked
      if story.account_id == account_id
        story_id = story.id
        s[:recordings] = full_recording story_id
        stories_obj << s
      end
    end

    return stories_obj
  end

  def full_recording story_id
    recordings_array = []
    recordings = Recording.where(story_id: story_id.to_s)
    recordings.each do |recording|
      recording_obj = {}
      recording_obj[:id] = recording.id
      recording_obj[:url] = recording.url
      recording_obj[:length] = recording.length
      recording_obj[:created_at] = recording.created_at
      recordings_array << recording_obj
    end
    return recordings_array
  end
end
