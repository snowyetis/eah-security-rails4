class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_action :authenticate_user!, only: [:edit]

  add_breadcrumb "Home", :root_path


  # GET /resource/sign_up
  def new
    add_breadcrumb "Create Account"
    super
  end

  # POST /resource
  def create
    @user = User.new(user_params)

  respond_to do |format|
      if @user.save
        format.html { redirect_to home_index_path, notice: 'Your access request has been sent to an admin. Upon approval, you will receive an e-mail.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /resource/edit
  def edit
    add_breadcrumb "Edit Account Details"

    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    # devise_parameter_sanitizer.for(:sign_up) << [:email, :password, :password_confirmation, :first_name, :last_name, :address, :city, :state, :zip, :affiliation]
    accessible = [ :first_name, :last_name, :address, :city, :state, :zip, :affiliation, :email, :role_id]
    accessible << [ :password, :password_confirmation ]
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :attribute
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  def user_params
    accessible = [ :first_name, :last_name, :address, :city, :state, :zip, :affiliation, :email, :role_id]
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end
