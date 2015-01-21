class AdminController < ApplicationController
  def dash
    @content = full_accounts
  end

  def full_accounts
    @hash = {}
    @hash[:accounts] = []

    @accounts = Account.all
    @stories = []

    @accounts.each do |account|
      a = {}

      a[:account] = account
      a[:stories] = full_stories account

      @hash[:accounts] << a
    end
  end

  def full_stories account
    stories_obj = {}
    stories_obj[:stories] = []

    stories = Story.all
    recordings = []
    stories.each do |story|
      s = {}
      s[:story] << story
      s[:recordings] = []
      if story.account_id == account.id
        recordings = full_recording story
        s[:recordings] << recordings
      end
      stories_obj[:stories] << s
    end

    return stories_obj
  end

  def full_recording story
    recordings_obj = {}
    recordings_obj[:recordings] = []

    recordings = Recording.all

    recordings.each do |recording|
      r = {}
      if recording.story_id == story.id
        r[:recording] << recording
      end
      recordings_obj[:recordings] << r
    end

    return recordings_obj
  end
end
