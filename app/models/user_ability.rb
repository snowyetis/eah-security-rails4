class UserAbility
  include CanCan::Ability

  def initialize(user)
    # Basic user abilities
    can :read, Quote
    can :read, Product
  end
end
