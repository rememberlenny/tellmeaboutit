class Story < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  has_many :recordings, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  def self.begin_followup_texts(uid, sid, rid)

  end
end

