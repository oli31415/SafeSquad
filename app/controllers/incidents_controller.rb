class IncidentsController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_incident, only: [:show, :chat, :helper, :close]

  def create
    incident = Incident.new(incident_params)
    incident.user = current_user
    incident.is_closed = false
    authorize incident

    if incident.save
      redirect_to incident_page_path(Incident.last)
    else
      redirect_to root_path, notice: "Incident could not be created."
    end
    return incident.id
  end

  def show
    @user_is_affected = @incident.user == current_user # use this to display either for affected or helper
    if @user_is_affected && @incident.incident_type == "yellow"
      redirect_to ask_type_path(@incident)
      return 0
    end
    # @incident
    # @responder (if there is no responder yet this will be nil)

    unless @user_is_affected # if we're not the affected user, make me a responder
      if Responder.all.find { |r| r.user == current_user && !r.incident.is_closed? }.nil?
        @responder = make_responder(@incident)
      else
        @responder = @incident.responders.find { |r| r.user == current_user }
      end
    else # if we are the affected user, try to find the the responder
      @responder = @incident.responders.find { |r| r.has_accepted? }
    end
  end

  def index
    @incidents = current_user.incidents
    authorize @incidents
    @responders = current_user.responders
  end

  def chat
    @responder = @incident.responders.find { |r| r.has_accepted? }
    # @user_is_affected = @incident.user == current_user
    # @other_user = @user_is_affected ? @responder : @incident.user # other user will be used for chat
  end

  def ask_type
    @incident = Incident.find(params[:id])
    authorize @incident
    @types = [
      "many",
      "different",
      "types",
      "here"
    ]
  end

  def set_type
    incident = Incident.find(params[:id])
    incident.incident_type = params[:incident][:incident_type]
    authorize incident

    if incident.save
      redirect_to incident_page_path(incident)
    else
      redirect_to root_path, notice: "Incident could not be created."
    end
  end

  def helper
    # update responder.has_arrived so that the text changes for affected
    @responder = @incident.responders.find { |r| r.user == current_user && !r.incident.is_closed? }
    @responder.has_arrived = true
    @responder.save

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
    return responder
  end

  def set_incident
    @incident = Incident.find(params[:id])
    authorize @incident
  end

  def incident_params
    params.require(:incident).permit(:incident_type)
  end

  def user_not_authorized
    # when one user closes the case, the other user should be redirected to the root
    # flash[:alert] = "You are not authorized to perform this action."
    redirect_to root_path
  end
end
