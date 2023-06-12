class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    user == record # Add any additional authorization logic here
  end

  def ask_medical?
    user == record # Add any additional authorization logic here
  end

  def set_medical?
    user == record # Add any additional authorization logic here
  end
end
