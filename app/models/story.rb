class Story < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  has_many :recordings, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  def self.begin_followup_texts(uid, sid, rid)
    u = User.find(uid)
    option = find_question_to_ask sid

    send_message(u.phone_number,
  end

  def find_question_to_ask
    story = Story.find(sid)

    options = question_options
    options.each do |option|
      if story[option] != nil
        return option
      end
    end
  end

  def question_options
    options = [
      {
        field: "name",
        question: "What is your ?"
      },
      {
        field: "gender",
        question: "What is your ?"
      },
      {
        field: "age",
        question: "What is your ?"
      },
      {
        field: "location",
        question: "What is your ?"
      },
      {
        field: "selected_recording_id",
        question: "What is your ?"
      },
      {
        field: "breakup_role",
        question: "What is your ?"
      },
      {
        field: "pullquote",
        question: "What is your ?"
      },
      {
        field: "breakup_type",
        question: "What is your ?"
      },
      {
        field: "user_id",
        question: "What is your ?"
      },
      {
        field: "start_dating",
        question: "When did you start ?"
      },
      {
        field: "end_dating",
        question: "When did you end ?"
      }
    ]
    return options
  end
end

