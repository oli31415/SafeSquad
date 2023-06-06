class RespondersPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  # user here is current_user
  # record here is the responder

  def accept?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
