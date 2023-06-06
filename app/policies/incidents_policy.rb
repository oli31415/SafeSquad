class IncidentsPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  before_action :set_responder, only: [:chat?, :helper?, :close?]

  # user here is current_user
  # record here is the incident

  def create?
    true
  end

  def show?
    !record.is_closed?
  end

  def chat?
    return false if record.is_closed?

    # creator of incident or responder is allowed to chat.
    record.user == user || @responder == user
  end

  def helper?
    return false if record.is_closed?

    # the responder is allowed to help
    @responder == user
  end

  def close?
    return false if record.is_closed?

    # creator of incident or responder is allowed to close the incident.
    record.user == user || @responder == user
  end

  private

  def set_responder
    @responder = recrod.responders.find { |r| r.has_accepted? }
  end
end
