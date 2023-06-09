class IncidentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  # user here is current_user
  # record here is the incident
  def index?
    true
  end

  def create?
    true
  end

  def ask_type?
    return false if record.is_closed?

    record.user == user
  end

  def set_type?
    return false if record.is_closed?

    record.user == user
  end

  def show?
    !record.is_closed?
  end

  def chat?
    return false if record.is_closed?

    @responder = record.responders.find { |r| r.has_accepted? }
    # creator of incident or responder is allowed to chat.
    record.user == user || @responder.user == user
  end

  def helper?
    return false if record.is_closed?

    @responder = record.responders.find { |r| r.has_accepted? }
    # the responder is allowed to help
    @responder.user == user
  end

  def close?
    return false if record.is_closed?

    @responder = record.responders.find { |r| r.has_accepted? }
    # creator of incident or responder is allowed to close the incident.
    record.user == user || @responder.user == user
  end

  def destroy?
    return false if record.is_closed?

    # creator of incident is allowed to close the incident.
    record.user == user
  end

  def notification?
    true
  end
end
