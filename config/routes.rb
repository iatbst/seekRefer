SeekRefer::Application.routes.draw do
  
  get 'autocomplete_company_name' => 'application#autocomplete_company_name'
  
  get "region_page/index"
  devise_for :users
  resources :companies
  resources :users
  resources :job_posts do
    get :autocomplete_position_name, :on => :collection
    get :autocomplete_company_name, :on => :collection
  end
  resources :follow_rules
  root 'homes#index'
  get 'homes' => 'homes#index'
  
  #user sign up page
  #match '/signup',  to: 'users#signup',            via: 'get'
  match '/signin',  to: 'devise/sessions#new',    via: 'get'
  #match '/signout', to: 'sessions#destroy', via: 'delete'
  
  #email to user
  get 'connects/send_request/:id' => 'connects#send_request'
  get 'connects/accept_request' => 'connects#accept_request'
  get 'connects/ignore_request' => 'connects#ignore_request'
  get 'connects/disconnect/:id' => 'connects#disconnect'
  post 'users/create' => 'users#create'
  get 'connects' => 'connects#index'

  
  get 'refer_requests/send_request' => 'refer_requests#send_request'
  post 'refer_requests/recv_request' => 'refer_requests#recv_request'
  get 'refer_request/view_profile' => 'refer_requests#view_profile'
  get 'refer_request/ignore_request' => 'refer_requests#ignore_request'
  get 'refer_request/upload_resume' => 'refer_requests#upload_resume'
  post 'refer_request/save_resume' => 'refer_requests#save_resume'
  
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
  
  #linkedin test
  get 'linkedin/get_token' => 'linkedin#get_token'
  get 'linkedin/accept' => 'linkedin#accept'
  get 'linkedin/get_companies' => 'linkedin#get_companies'
  get 'linkedin/get_company' => 'linkedin#get_company'
  get 'linkedin/new' => 'linkedin#new'
  post 'linkedin/create' => 'linkedin#create'
  get 'linkedin/get_jobs_by_company' => 'linkedin#get_jobs_by_company'
 
 
  
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
