class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :json

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #  def devise_parameter_sanitizer
  #    if resource_class == User
  #      User::ParameterSanitizer.new(User, :user, params)
  #    else
  #      super # Use the default one
  #    end
  #  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
   u.permit(:sign_up, keys: [:first_name, :last_name,
     :address, :city, :state, :zip, :affiliation, :phone])
    end
  end

  # def authenticate_user!
  #   if user_signed_in?
  #     super
  #   else
  #     redirect_to new_user_session
  #   end
  # end

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
