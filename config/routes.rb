Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :simple, only: :index
  resources :sandbox, only: :show
end
