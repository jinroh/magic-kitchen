class Home::RecsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json
  
  def index
    @recs = current_user.recs_recipes
    respond_with @recs
  end
end