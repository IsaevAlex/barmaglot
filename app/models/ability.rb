class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :destroy , PostComment do |comment|
         comment.try(:user_id) == user.id
    end
  end
end
