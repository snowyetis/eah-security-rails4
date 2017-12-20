class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :json

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_product_page
  before_action :is_home_page

  def current_ability
    @current_ability ||= case
    when current_user
      UserAbility.new(current_user)
    when current_admin
      AdminAbility.new(current_admin)
    else
      GuestAbility.new
    end
  end

  def is_product_page
    puts original_url
    if original_url.downcase().include? "products"
      @show_top_nav_bar = false
      @product_home = true
      @root_home = false
    else
      @show_top_nav_bar = true
      @product_home = false
      @root_home = false
    end
  end

  def is_home_page
    puts original_url
    if original_url.downcase.include? "home"
      @show_top_nav_bar = false
      @product_home = false
      @root_home = true
    else
      @show_top_nav_bar = true
      @product_home = false
      @root_home = false
    end
  end

  protected

    def configure_permitted_parameters
      accessible = [ :first_name, :last_name, :address, :city, :state, :zip, :affiliation, :email, :role_id ]
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

    def is_admin(resource_or_scope)
      if resource_or_scope.admin
        @admin_navbar = true
      end

      if resource_or_scope.admin == false
        @admin_navbar = false
      end
    end

    def original_url
      self.request.original_url
    end

  # def current_user
  #   User.new(session[:id])
  # end

  # helper_method :current_user

end
