class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  
  def ensure_signup_complete
    # Убеждаемся, что цикл не бесконечный
    return if action_name == 'finish_signup'

    # Редирект на адрес 'finish_signup' если пользователь
    # не подтвердил свою почту
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
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
