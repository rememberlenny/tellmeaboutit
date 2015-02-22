class Recording < ActiveRecord::Base
  belongs_to :story
  validates :story_id, presence: true
end
