STProject::Application.routes.draw do
  resources :users
  resources :articles
  get "session/signin"

  get "session/signout"

  resources :sessions
  
  get "my_pages/about"

  get "my_pages/contact"

  get "mainnews/index"
  match '/about',    to: 'my_pages#about'
  match '/contact',    to: 'my_pages#contact'
  match '/index',	to: 'mainnews#index'
  match '/logout',	to: 'sessions#signout'
  match '/login',	to: 'sessions#signin'
  match '/profile',	to: 'users#current'
  match '/register',	to:'users#new'
  match '/members',	to:'users#index'
  match '/articles', to: 'mainnews#index'
  match '/new', 	to:'articles#new'
  match '/admin/:id',	to:'users#makeadmin'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'mainnews#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
