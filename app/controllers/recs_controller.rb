class RecsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json
  
  def index
    @recs = current_user.recipes_recommandations
    respond_with @recs
  end
end