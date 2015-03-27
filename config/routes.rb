Rails.application.routes.draw do
  get 'textthread/show'

  get 'monitor/dashboard'

  get 'textexchange/welcome'

  get 'textexchange/follow_up_questions'

  devise_for :users
  root to: 'static_pages#splash'
  get 'submit' => 'static_pages#submit'
  get 'listen' => 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#home'

  post 'sms/connection' => 'textexchange#text_delegate'

  get  'voice/connection'       => 'voiceexchange#voice_delegate'
  get  'voice/after_recording'  => 'voiceexchange#after_recording'

  resources :textthread

  resources :stories do
    resources :recordings
  end
  post  'phone_verifications/verify_from_message' => 'phone_verifications#verify_from_message'
  get   'dash'                  => 'stories#dashboard'
  get   'verify'                => 'phone_verifications#verify'
  post  'resend_verification'   => 'phone_verifications#resend_verification'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
