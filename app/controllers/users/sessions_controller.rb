class Users::SessionsController < Devise::SessionsController
  before_filter :configure_sign_in_params, only: [:create]
  # Prevent admin from hittinf user.
 before_filter :authenticate_admin!
 before_filter :set_admin_flag

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    sign_out current_user if user_signed_in?
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in)
  end

  private

  def set_admin_flag
    @adminFlag = false
  end

end
