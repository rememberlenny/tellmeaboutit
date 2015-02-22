class Recording < ActiveRecord::Base
  belongs_to :story
  validates :story_id, presence: true
  default_scope -> { order(created_at: :desc) }
end
