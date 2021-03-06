Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
            controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'static_pages#home'
  get 'about' => 'static_pages#about'
  #get 'users/:id', to: 'users#show', as: "user"
  post 'like/:spot_id', to: 'likes#like', as: 'like'
  delete 'unlike/:spot_id', to: 'likes#unlike', as: 'unlike'
  get 'like_ranking', to: 'ranking#like_ranking'
  get 'follower_ranking', to: 'ranking#follower_ranking'
  post 'image_spot', to: 'spots#image_create', as: 'image_create'
  resources :profiles, only:[:new,:create,:edit, :update]
  resources :users, only:[:index, :show] do
    member do
      get :followings, :followers, :like_spots
    end
  end
  resources :spots do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create,:destroy]
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
