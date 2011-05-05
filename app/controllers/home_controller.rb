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
    if !user_signed_in?
      redirect_to root_path
    else
      @recipes = current_user.recipes
    end
  end
  
end
