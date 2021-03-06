Rails.application.routes.draw do
  # API
  mount API::API => '/api'

  # help
  get 'help' => 'help#index'
  get 'help/:category/:file'  => 'help#show', as: :help_page

  # root path
  authenticated :user do
    root to: "ideas#index" #, as: :authenticated_root
  end
  unauthenticated do
    root to: "home#index", as: :unauthenticated_root
  end

  devise_for :users, :path => ''
  devise_scope :user do
    get     "/sign_in"    => "devise/sessions#new"
    delete  "/sign_out"   => "devise/sessions#destroy"
    get     "/register" => "devise/registrations#new"
  end

  concern :commentable do
    resources :comments, only: [:create]
  end

  resources :ideas, concerns: [:commentable]
  resources :users, only: [:show, :edit, :update]
  post   'follow'   => 'users#follow'
  post   'unfollow'   => 'users#unfollow'
  post   'like'   => 'ideas#like'
  post   'unlike'   => 'ideas#unlike'

  get '/uploads/uptoken' => 'uploads#uptoken'

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
