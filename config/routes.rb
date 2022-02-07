Rails.application.routes.draw do
  root 'application#index'

  resource :formats, only: :create
end
