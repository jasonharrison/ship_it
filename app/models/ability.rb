class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    case user.role
    when "admin"
      # admins can perform any action on any objects
      can :manage, :all
    when "employee"
      # employees can only manage DropOffPackages they created
      can :manage, DropOffPackage, user_id: user.id
    end
  end
end
