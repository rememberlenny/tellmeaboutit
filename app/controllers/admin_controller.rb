class AdminController < ApplicationController
  def dash
    @content = full_accounts
  end

  def full_accounts
    @hash = {}
    @hash[:accounts] = []

    accounts = Account.all

    saccounts.each do |account|
      a = {}
      id = account.id
      a[:account] = account
      a[:stories] = full_stories account_id

      @hash[:accounts] << a
    end
  end

  def full_stories account_id
    stories_obj = {}
    stories_obj[:stories] = []

    stories = Story.where(account_id: account_id)
    recordings = []
    stories.each do |story|
      s = {}
      s[:story] = story
      s[:recordings] = []
      if story.account_id == account.id
        story_id = story.id
        recordings = full_recording story_id
        s[:recordings] << recordings
      end
      stories_obj[:stories] << s
    end

    return stories_obj
  end

  def full_recording story_id
    recordings_obj = {}
    recordings_obj[:recordings] = []

    recordings = Recording.where(story_id: story_id)

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
