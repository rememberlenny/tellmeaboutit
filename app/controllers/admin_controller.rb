class AdminController < ApplicationController
  def dash
    @content = full_accounts
  end

  def full_accounts accounts
    @accounts = Account.all

    accounts.each do |account|
      account.stories = []
      full_stories account
    end
  end

  def full_stories account
    @stories = Story.all

    @stories.each do |story|
      if story.account_id == account.id
        account.stories.push story
        full_recording story
      end
    end
  end

  def full_recording story
    @recordings = Recording.all

    @recordings.each do |recording|
      if recording.story_id == story.id
        story.stories.push recording
      end
    end
  end
end
