class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        if resource.admin?
            admin_dashboard_index_path
        else
            trader_dashboard_index_path
        end
    end
end
