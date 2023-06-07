class IncidentChannel < ApplicationCable::Channel
  def subscribed
    incident = Incident.find(params[:id])
    stream_for incident
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
