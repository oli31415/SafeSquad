class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @incident = Incident.all.reverse.find { |i| !i.is_closed? }
  end
end
