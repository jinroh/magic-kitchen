class HomeController < ApplicationController

  def index
    redirect_to user_root_path if user_signed_in?
  end
  
  def show
    if user_signed_in?
      @recipes = current_user.recipes
    else
      redirect_to root_path
    end
  end
  
end
