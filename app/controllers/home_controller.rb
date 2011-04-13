class HomeController < ApplicationController

  # root_path
  # GET /
  def index
    redirect_to user_root_path if user_signed_in?
  end
  
  # user_root_path
  # GET /me
  # GET /users/me
  def show
    redirect_to root_path unless user_signed_in?
    @recipes = current_user.recipes
  end
  
end
