class Story < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :breakup_type

  def previous
    Story.where(["id < ?", id]).where(was_checked: true).last
  end

  def next
    Story.where(["id > ?", id]).where(was_checked: true).first
  end

  def self.search(query)
    where("name like ?", "%#{query}%")
  end
end
