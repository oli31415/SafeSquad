Rails.application.routes.draw do
  get 'missions/show'
  # resources :users, only: [:show, :edit, :update]
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
  get "incidents/:id/cancel", to: "incidents#destroy", as: "undo_create_incident" # delete the incident on incident type page
  get "notification", to: "incidents#notification", as: "notification" # TODO: change
  get "searching", to: "incidents#searching", as: "searching"

  get "incidents/:id/review", to: "incidents#ask_review", as: "review_page" # review page
  put "incidents/:id/review", to: "incidents#set_review", as: "set_review" # save review

  get "incidents/:id/type", to: "incidents#ask_type", as: "ask_type" # ask incident_type page
  patch "incidents/:id/type", to: "incidents#set_type", as: "set_type" # save incident_type

  # anyone can get here, but the display dependes on has_accepted & current_user:
  get "incidents/:id", to: "incidents#show", as: "incident_page" # get to responder page & create responder

  # TODO: chat model, chat routes ...

  get "profile/:id", to: "users#show", as: "profile"
  get "missions", to: "incidents#index", as: "missions"
  get "profile/:id/medical", to: "users#ask_medical", as: "ask_medical"
  patch "profile/:id/medical", to: "users#set_medical", as: "set_medical"

  get '/fake_call', to: 'pages#fake_call'

end
