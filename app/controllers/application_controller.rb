class ApplicationController < ActionController::Base
  protect_from_forgery
  # Reditect to a default route when user inputs a wrong one
  rescue_from ActionController::RoutingError do |exception|
    flash[:error] = "There is no such route"
    redirect_to root_path
  end
end
