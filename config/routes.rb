Rails.application.routes.draw do
  devise_for :users
  get 'home/page'
  root 'home#page'
  resources :photos
  get 'portfolio', to: 'photos#portfolio'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
