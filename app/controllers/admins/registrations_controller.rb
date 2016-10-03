class Admins::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update, :approve_user]

 # before_filter do
 #   redirect_to new_user_session_path unless current_admin
 # end

 before_action :set_user, only: [:approve_user]

  def get_approved_users
    if params[:approved] == "false"
      @users = User.where(approved: false)
    else
      @users = User.all
    end
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
        sign_in @user, :bypass => true
        if @user.approved == true
          AdminMailer.new_user_approved(@user).deliver
        end
        format.json { render json: @user }
      else
        format.json { render json: @user.error }
      end
    end
  end

  def index
    get_approved_users
  end

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
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
      devise_parameter_sanitizer.for(:sign_up) << :attribute
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) << :approved
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

end
