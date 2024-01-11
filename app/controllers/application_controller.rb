class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
<<<<<<< HEAD
  
    def after_sign_in_path_for(resource)
      if resource.admin?
        admin_dashboard_index_path
      else
        trader_dashboard_index_path
      end
=======

    def after_sign_in_path_for(resource)
        if resource.admin?
            admin_dashboard_index_path
        else
            trader_dashboard_index_path
         end
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
>>>>>>> 09588c33104fc579383e97f7710d31d199268ea1
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
    end
  end
  