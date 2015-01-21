class AdminController < ApplicationController
  def dash
    @hash = full_accounts
  end

  def index
    @hash = full_accounts
    render json: @hash
  end

  def full_accounts
    @hash = {}
    @hash[:accounts] = []

    accounts = Account.all

    accounts.each do |account|
      a = {}
      account_id = account.id
      a[:account] = account
      a[:account][:stories] = full_stories account_id

      @hash[:accounts] << a
    end
    return @hash
  end

  def full_stories account_id
    stories_obj = []
    stories = Story.where(account_id: account_id)
    recordings = []
    stories.each do |story|
      s = {}
      s[:story] = story
      s[:recordings] = []
      if story.account_id == account_id
        story_id = story.id
        recordings = full_recording story_id
        s[:recordings] << recordings
      end
      stories_obj << s
    end

    return stories_obj
  end

  def full_recording story_id
    recordings_obj = {}

    recordings = Recording.where(story_id: story_id.to_s)
    recordings_obj[:recordings] = recordings

    return recordings_obj
  end
end
