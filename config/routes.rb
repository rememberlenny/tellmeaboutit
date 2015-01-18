Rails.application.routes.draw do
  get 'say_intro' =>        'twilio_responses#say_intro'
  get 'get_id' =>           'twilio_responses#id_number'
  get 'handle_response' =>  'handle_response#save'
end
