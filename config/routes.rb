Magickitchen::Application.routes.draw do
  root :to => "home#index"
  
  # Authentification and User routing
  devise_for :users, :path => "user"
  
  get "/me" => "home#show", :as => :user_root
  # get "/users" => "users#index"
  # get "/user" => "users#index"
  resources "user", :controller => :users, :as => :user, do
    resources :likes
  end
  
  # Recipes
  resources :recipes
  
  # Tags
  namespace :tags do
    resources :recipes
  end
end

