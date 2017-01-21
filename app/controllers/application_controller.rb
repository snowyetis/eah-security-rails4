class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :json

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
      accessible = [ :first_name, :last_name, :address, :city, :state, :zip, :affiliation, :email]
      accessible << [ :password, :password_confirmation ]
    end

  private

    def after_sign_up_path_for(resource)
      if resource.approved == false
        home_pending_path
      end
    end

    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.admin == false
        home_index_path
      else
        admins_signed_up_path
      end
    end

    def after_sign_out_path_for(resource)
       home_exit_path
    end
end
