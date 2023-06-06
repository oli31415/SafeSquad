class IncidentController < ApplicationController
  before_action :set_incident, only: [:show, :chat, :helper, :close]
  before_action :set_responder, only: [:show, :chat]

  def create
    incident = Incident.new(incident_params)
    incident.user = current_user
    incident.is_closed = false
    authorize incident

    if incident.save
      redirect_to incident_page_path(incident)
    else
      redirect_to root_path, notice: "Incident could not be created."
    end
  end

  def show
    @user_is_affected = @incident.user == current_user # use this to display either for affected or helper
    # @incident
    # @responder (if there is no responder yet this will be nil)

    unless @user_is_affected # if we're not the affected user, make me a responder
      make_responder(@incident)
    end
  end

  def chat
    # @user_is_affected = @incident.user == current_user
    # @other_user = @user_is_affected ? @responder : @incident.user # other user will be used for chat
  end

  def helper
    # @incident -> @incident.user
  end

  def close
    @incident.is_closed = true

    if @incident.save
      redirect_to root_path
    else
      redirect_back fallback_location: root_path, notice: "Incident could not be closed."
    end
  end

  private

  def make_responder(incident)
    responder = Responder.new
    responder.user = current_user
    responder.incident = incident
    responder.has_accepted = false

    responder.save
    redirect_to incident_page_path(incident)
  end

  def set_incident
    @incident = Incident.find(params[:id])
    authorize @incident
  end

  def set_responder
    @responder = @incident.responders.find { |r| r.has_accepted? }
    authorize @responder
  end

  def incident_params
    params.require(:incident).permit(:type)
  end
end
