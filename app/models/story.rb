class Story < ActiveRecord::Base
  belongs_to :user
  has_many :recordings, dependent: :destroy
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
end
