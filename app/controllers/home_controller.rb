class HomeController < ApplicationController

  respond_to :json, :html

  def index
    redirect_to user_root_path if user_signed_in?
  end

  def dashboard
    if !user_signed_in?
      redirect_to root_path
    else
      @user = current_user
      respond_with @user
    end
  end
  
end
