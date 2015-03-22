class Story < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  has_many :recordings, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  def self.begin_followup_texts(uid, sid, rid)
    tt = Textthread.where(user_id: uid)
    t = tt.last
    puts 'Got begin_followup_texts tt.count: ' + tt.count.to_s
    t.state = 'recorded_audio' # State for detecting response

    Story.send_sms_thank(uid)
    Story.send_sms_followup(uid)
  end

  def self.send_sms_thank (uid)
    u = User.find(uid)
    recording_url = 'http://lkb.cc/'
    response = Textthread.thread_state(recording_url)
    response_thank = response[:response_thank][:message]
    Textthread.send_message(u.phone_number, response_thank)
  end

  def self.send_sms_followup (uid)
    u = User.find(uid)
    response = Textthread.thread_state
    response_followup = response[:response_followup][:message]
    Textthread.send_message(u.phone_number, response_followup)
  end

  def self.create_story_with_thread thread_id
    puts 'Ran create_story_with_thread thread_id'
    user = User.get_user_with_thread(thread_id)
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

