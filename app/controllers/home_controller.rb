class HomeController < ApplicationController

  respond_to :json, :html

  def index
    if user_signed_in?
      @user = current_user
      respond_with @user do |format|
        format.html { render :dashboard }
        format.json { render :dashboard }
      end
    else
      render :index
    end
  end
  
  # def dashboard
  #     if !user_signed_in?
  #       redirect_to root_path
  #     else
  #       @user = current_user
  #       respond_with @user
  #     end
  #   end
    
end
