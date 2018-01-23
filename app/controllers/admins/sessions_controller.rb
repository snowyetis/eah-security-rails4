class Admins::SessionsController < Devise::SessionsController
before_filter :configure_sign_in_params, only: [:create]
before_action :hide_nav, only: [:new]

# Prevent user from hitting admin.
before_filter :authenticate_user!
before_action :set_admin_flag

  # GET /resource/sign_in
  def new
    super
    # respond_with resource, location:  admins_signed_up_path

  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      respond_with resource, :location => admins_signed_up_path
    end
  end

  # DELETE /resource/sign_out
  def destroy
    sign_out current_admin if admin_signed_in?
      super

    current_admin = nil
    current_ability = nil
  end

  protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in)
    end

  private

    def set_admin_flag
      @adminFlag = true
    end

end
