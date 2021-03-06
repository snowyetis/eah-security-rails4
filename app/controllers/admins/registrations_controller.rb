class Admins::RegistrationsController < Devise::RegistrationsController
  load_and_authorize_resource

  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update, :approve_user]
  before_action :authenticate_admin!
  add_breadcrumb "Home", :home_index_path

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

 before_action :set_user, only: [:approve_user]

  def get_approved_users
    if params[:approved] == "false"
      @approvedClass = false
    else
      @approvedClass = true
    end

    users_scope = User.where(approved: @approvedClass)

    users_scope = User.where(email: params[:email]) unless params[:email].blank?
    users_scope = User.where(first_name: params[:first_name]) unless params[:first_name].blank?
    users_scope = User.where(last_name: params[:last_name]) unless params[:last_name].blank?
    users_scope = User.where(address: params[:address]) unless params[:address].blank?
    users_scope = User.where(city: params[:city]) unless params[:city].blank?
    users_scope = User.where(state: params[:state]) unless params[:state].blank?
    users_scope = User.where(affiliation: params[:affiliation]) unless params[:affiliation].blank?
    users_scope = User.where(approved: params[:approved]) if params[:approved] == "1"

    @users = smart_listing_create(:users, users_scope, partial: "admins/shared/approvalgrid" )
  end

  def approve_user
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(params[:id])
    @user.approved = params[:approved]
    @update = update_resource(@user, account_update_params)

    respond_to do |format|
      if @update
        bypass_sign_in(@user)
        if @user.approved == true
          AdminMailer.new_user_approved(@user.email).deliver
        end
        format.js { }
        format.json { render json: @user }
      else
        format.js {}
        format.json { render json: @user.error }
      end
    end
  end

  def index
    add_breadcrumb "Administrator Home"

    @products = Product.all

    get_approved_users
  end

  # GET /resource/sign_up
  def new
    add_breadcrumb "Create Admin Account"

    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    add_breadcrumb "Edit Admin Account Details"

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
      # devise_parameter_sanitizer.for(:sign_up) << :attribute
      # devise_parameter_sanitizer.permit(:sign_up)
      accessible = [  :email, :admin, :role_id]
      accessible << [ :password, :password_confirmation ]
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      # devise_parameter_sanitizer.for(:account_update) << :approved
      devise_parameter_sanitizer.permit(:account_update)
    end

    # The path used after sign up.
    def after_sign_up_path_for(resource)
      super(resource)
    end

    # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(resource)
      super(resource)
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

  private

    def set_user
      @user = User.find(params[:id])
      puts "User set"
    end

    def user_params
      params.require(:users).permit(:id, :approved)
      puts "Param set"
    end

    def admin_params
      accessible = [  :email, :role_id]
      accessible << [ :password, :password_confirmation ] unless params[:admin][:password].blank?
      params.require(:admin).permit(accessible)
    end

    def set_admin
      @admin = Admin.find(params[:id])
    end

end
