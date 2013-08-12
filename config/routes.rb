SeekRefer::Application.routes.draw do
  
  get "region_page/index"
  devise_for :users
  resources :companies
  resources :users
  resources :job_posts
  resources :follow_rules
  root 'homes#index'
  get 'homes' => 'homes#index'
  
  #user sign up page
  #match '/signup',  to: 'users#signup',            via: 'get'
  match '/signin',  to: 'devise/sessions#new',    via: 'get'
  #match '/signout', to: 'sessions#destroy', via: 'delete'
  
  #email to user
  get 'connect_request/send_request/:id' => 'connect_requests#send_request'
  get 'connect_request/accept_request' => 'connect_requests#accept_request'
  get 'connect_request/ignore_request' => 'connect_requests#ignore_request'
  get 'connect_request/disconnect/:id' => 'connect_requests#disconnect'
  post 'users/create' => 'users#create'
  get 'connections' => 'connections#index'

  
  get 'refer_requests/send_request' => 'refer_requests#send_request'
  post 'refer_requests/recv_request' => 'refer_requests#recv_request'
  get 'refer_request/view_profile' => 'refer_requests#view_profile'
  get 'refer_request/ignore_request' => 'refer_requests#ignore_request'
  
  #refer case
  get 'refer_cases/show_referrer' => 'refer_cases#show_referrer'
  get 'refer_cases/show_referral' => 'refer_cases#show_referral'
  get 'refer_cases/create/:id' => 'refer_cases#create'
  get 'refer_cases/edit' => 'refer_cases#edit'
  patch 'refer_cases/destroy' => 'refer_cases#destroy'
  patch 'refer_cases/update' => 'refer_cases#update'
  get 'refer_cases/feedback' => 'refer_cases#feedback'
  
  #refer post
  post 'refer_posts/create' => 'refer_posts#create'
 
 
  
  #resources :sessions, only: [:new, :create, :destroy]
 
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
