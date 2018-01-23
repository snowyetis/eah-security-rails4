class AdminAbility
  include CanCan::Ability

  def initialize(admin)
    can :view, Home
    can :manage, :all
  end
end
