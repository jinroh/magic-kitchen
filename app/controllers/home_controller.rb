class HomeController < ApplicationController

  def index
    redirect_to user_root_path if user_signed_in?
  end
  
  def dashboard
    redirect_to root_path unless user_signed_in?
  end
  
end
