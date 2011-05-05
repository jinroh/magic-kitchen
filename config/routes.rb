Magickitchen::Application.routes.draw do
  root :to => 'home#index'
  
  # Authentification and User routing
  devise_for :users, :path => 'user'
  
  get '/me'       => 'home#show', :as => :user_root
  get '/user/me'  => 'home#show'
  get '/users'    => 'users#index'
  get '/user'     => 'users#index'
  get '/user/:id' => 'users#show', :as => :user
  
  # Recipes
  resources :recipes
  
  # Tags
  namespace :tags do
    resources :recipes
  end
end
