class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    
    can :manage, [Recipe, Like, Favorite, History], :user_id => user.id
  end
end
