class LikesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  
  respond_to :html, :json
  
  def index
    @likes = Like.by(current_user).includes(:recipe)
    respond_with @likes
  end
  
  def create
  end

  def show
  end
  
  def update
  end
  
  def destroy
  end
  
end
