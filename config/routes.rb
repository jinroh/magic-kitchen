Magickitchen::Application.routes.draw do
  root :to => "home#index"
  
  devise_for :users, :path => "user"
  
  get "/me" => "home#show", :as => :user_root
  
  get "/users" => "users#index", :as => :user_index
  resources :user, :controller => :users, :only => [:index, :show], do
    member do
      get :following, :followers
    end
  end
  
  resources :recipes
  
  namespace :tags do
    resources :recipes
  end
end

