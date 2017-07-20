class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    # admins can perform any action on any objects
    can :manage, :all if user.role == "admin"
    # employees can only manage DropOffPackages they created
    can :manage, DropOffPackage, user_id: user.id if user.role == "employee"
  end
end
