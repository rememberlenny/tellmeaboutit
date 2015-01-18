Rails.application.routes.draw do
  get 'say_intro' =>        'twilio_responses#say_intro'
  match 'get_id' =>          'twilio_responses#id_number', :via => [:post]
  get 'handle_response' =>  'handle_response#save'

  root 'static_page#home'
end
