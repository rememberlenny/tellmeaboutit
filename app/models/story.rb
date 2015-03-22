class Story < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  has_many :recordings, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  def self.begin_followup_texts(uid, sid, rid)
    u = User.find(uid)
    tt = Textthread.where(user_id: u.id, story_id: s.id)
    t = tt.first

    t.state = 'recorded_audio' # State for detecting response

    option = Story.find_question_to_ask sid
    recording_url = 'http://lkb.cc/'

    response_thank = 'Thank you for submitting your recording. You can now view it here: ' + recording_url
    response_followup = 'We would like to ask you for details about your story. Reply YES to continue.'
    Textthread.send_message(u.phone_number, response_thank)
    Textthread.send_message(u.phone_number, response_followup)
  end

  def self.create_story_with_thread thread_id
    puts 'Ran create_story_with_thread thread_id'
    user = get_user_with_thread(thread_id)
    story = user.stories.new(origin: 'sms_thread')
    story.save
    options = Textthread.thread_state
    return options[:welcome]
  end

  def self.find_question_to_ask sid
    story = Story.find(sid)

    # >
    # >> This needs work
    # >
    options = question_options
    options.each do |option|
      if story[option.field] == nil
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

