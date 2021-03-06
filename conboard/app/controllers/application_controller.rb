class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  # Override
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Handle Unauthorized access
  rescue_from CanCan::AccessDenied do |exception|
  	respond_to do |format|
          format.json { head :forbidden, content_type: 'text/html' }
          format.html { redirect_to main_app.root_url, notice: exception.message }
          format.js   { head :forbidden, content_type: 'text/html' }
  	end
  end
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
