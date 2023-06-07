Rails.application.routes.draw do
  devise_for :users

  # notes: everything is only possible while logged in.

  root to: "pages#home"

  # a (1) responder who has accepted can get here
  post "incidents", to: "incidents#create", as: "create_incident" # create incident
  get "incidents/:id/chat", to: "incidents#chat", as: "chat_page" # get to chat page # display depends on current_user
  get "incidents/:id/helper", to: "incidents#helper", as: "helper_page" # get to helper page
  get "responders/:id", to: "responders#accept", as: "accept" # accept incident
  get "responders/:id/cancel", to: "responders#destroy", as: "cancel" # cancel response
  get "incidents/:id/close", to: "incidents#close", as: "close" # close the case

  # anyone can get here, but the display dependes on has_accepted & current_user:
  get "incidents/:id", to: "incidents#show", as: "incident_page" # get to responder page & create responder

  # TODO: chat model, chat routes ...

  get "profile/:id", to: "users#show", as: "profile"
end
