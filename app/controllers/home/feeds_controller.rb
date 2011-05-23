class Home::FeedsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json
  
  def index
    @feeds = current_user.following_feed
    raise ActiveRecord::RecordNotFound if @feeds.nil?
    respond_with @feeds
  end
  
end