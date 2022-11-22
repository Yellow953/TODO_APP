Rails.application.routes.draw do
  devise_for :users

  get "/todos", to: "application#todos", as: "todos"

  root "application#index"
end
