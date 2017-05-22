class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def after_sign_up_path_for(resource)
    current_user
  end

  def after_sign_in_path_for(resource)
    current_user
  end

  def after_sign_out_path_for(resource)
    root_path
  end

 
  
  protected

	  def update_resource(resource, params)
	    resource.update_without_password(params)
	  end

	  def after_update_path_for(resource)
	    current_user
	  end
end
