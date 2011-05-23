class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied, :with => :error_403

  protected
  
  def error_403
    render :file => "#{Rails.public_path}/errors/403.html", :status => 403, :layout => false
  end
  
end
