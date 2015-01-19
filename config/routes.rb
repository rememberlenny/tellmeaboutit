Rails.application.routes.draw do
  resources :recordings

  get 'stories' => 'stories#index'
  get 'story/:id' => 'stories#show'

  # resources :stories


  get 'say_intro' =>        'twilio_responses#say_intro'
  get 'get' =>              'static_pages#home'
  match 'get_id',          to: 'twilio_responses#id_number',       :via => [:post, :get]
  match 'handle_response', to: 'handle_response#save',             :via => [:post, :get]
  match 'check_recording', to: 'twilio_responses#check_recording', :via => [:post, :get]
  match 'check_response',  to: 'twilio_responses#check_response',  :via => [:post, :get]
  match 'after_recording', to: 'twilio_responses#after_recording', :via => [:post, :get]

  root 'static_pages#signup'
end
