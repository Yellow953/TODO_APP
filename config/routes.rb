Rails.application.routes.draw do
  resources :todo_items
  resources :todos
  devise_for :users 

  get "/mytodos", to: "application#my_todos", as: "my_todos"
  get "/mytodos/:id/items", to: "application#my_todo_items", as: "my_todo_items"
  
  patch "/todo_item/:id/unmark", to: "application#unmark", as: "unmark_todo_item"
  patch "/todo_item/:id/mark", to: "application#mark", as: "mark_todo_item"

  root "application#index"
end