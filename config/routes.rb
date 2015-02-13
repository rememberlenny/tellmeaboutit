Rails.application.routes.draw do
  devise_for :users
  resources :recordings
  resources :stories

  get 'say_intro' =>        'twilio_responses#say_intro'
  get 'get' =>              'static_pages#home'
  get 'admin' =>            'admin#dash'
  get 'admin/all' =>        'admin#index'
  get 'generate' =>         'stories#generate'
  get 'listen' =>           'stories#index'
  get 'about' =>            'static_pages#about'
  get 'submit' =>           'stories#new'
  get 'thankyou' =>         'static_pages#thank_you'
  match 'get_id',          to: 'twilio_responses#get_id',          :via => [:post, :get]
  match 'handle_response', to: 'twilio_responses#save',            :via => [:post, :get]
  match 'check_recording', to: 'twilio_responses#check_recording', :via => [:post, :get]
  match 'check_response',  to: 'twilio_responses#check_response',  :via => [:post, :get]
  match 'after_recording', to: 'twilio_responses#after_recording', :via => [:post, :get]

  root 'static_pages#home'
end
