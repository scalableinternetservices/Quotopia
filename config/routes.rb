Rails.application.routes.draw do
  get '/tweets/new', to: 'tweets#new'

  get '/twitter/callback', to: 'sessions#create'
  post '/tweets/create', to: 'tweets#create'
  get '/tweets/error', to: 'tweets#error'

  resources :authentications
  get 'home/index'
  get '/vote/quote_count/:quote_id', to: 'votes#quote_count'
  get '/favorite_quotes/user', to: 'favorite_quotes#user'
  get '/search', to: 'searches#search'
  get '/typeahead', to: 'searches#typeahead'

  get '/category_ajax', to: 'categories#category_ajax'

  post 'comments/:content/:quote_id/:user_id', to: 'comments#destroy_from_params', as: 'comment_destroy'

  resources :favorite_quotes
  resources :votes
  resources :categories
  resources :quotes do
    put :favorite, on: :member    # favorite_quote_path(@quote)
    resources :comments
  end
  resources :authors
  devise_for :users, controllers: {:omniauth_callbacks => "omniauth_callbacks"}

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
  #     #     resources :sales do
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
