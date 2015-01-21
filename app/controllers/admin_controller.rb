class AdminController < ApplicationController
  def dash
    @content = full_accounts
  end

  def full_accounts
    @accounts = Account.all
    @stories = []
    @accounts.each do |account|
      stories = []
      stories = full_stories account
      @stories << stories
    end
  end

  def full_stories account
    @stories = Story.all
    stories = []

    @stories.each do |story|
      if story.account_id == account.id
        recordings = full_recording story
      end
      stories.push story
    end

    return stories
  end

  def full_recording story
    @recordings = Recording.all
    reocrdings = []

    @recordings.each do |recording|
      if recording.story_id == story.id
        recordings.push recording
      end
    end

    return recordings
  end
end
