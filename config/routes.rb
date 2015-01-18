Rails.application.routes.draw do
  get 'say_intro' =>        'twilio_responses#say_intro'
  match 'get_id',          to: 'twilio_responses#id_number', :via => [:post, :get]
  match 'handle_response', to: 'handle_response#save',       :via => [:post, :get]

  root 'static_page#home'
end
