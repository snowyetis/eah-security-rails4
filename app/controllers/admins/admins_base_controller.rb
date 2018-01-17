class AdminsBaseController < DeviseController


before_filter :verify_admin

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end

  private

    def verify_admin
      redirect_to root_url unless current_user.try(:admin?)
    end
