class IncidentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

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

    @responder = record.responders.find { |r| r.has_accepted? }
    # creator of incident or responder is allowed to chat.
    record.user == user || @responder == user
  end

  def helper?
    return false if record.is_closed?

    @responder = record.responders.find { |r| r.has_accepted? }
    # the responder is allowed to help
    @responder == user
  end

  def close?
    return false if record.is_closed?

    @responder = record.responders.find { |r| r.has_accepted? }
    # creator of incident or responder is allowed to close the incident.
    record.user == user || @responder == user
  end
end
