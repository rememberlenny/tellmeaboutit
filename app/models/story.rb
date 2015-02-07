class Story < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :breakup_type

  def previous
    Story.where(["id < ?", id]).last
  end

  def next
    Story.where(["id > ?", id]).first
  end
end
