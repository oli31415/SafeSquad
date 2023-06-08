class RespondersController < ApplicationController
  before_action :set_incident, only: [:accept]

  def accept
    if @incident.responders.find { |r| r.has_accepted? } # cannot accept when another user has already accepted
      redirect_to root_path, notice: "Another user has already accepted."
      return 0
    end

    responders = @incident.responders
    @responder = responders.find { |r| r.user == current_user }
    authorize @responder
    @responder.has_accepted = true

    if @responder.save
      redirect_to incident_page_path(@incident)
    else
      redirect_back fallback_location: root_path, notice: "Incident could not be closed."
    end
  end

  def destroy
    @responder = Responder.find(params[:id])
    authorize @responder
    @responder.destroy
    redirect_to root_path
  end

  private

  def set_incident
    @incident = Incident.find(params[:id])
  end
end
