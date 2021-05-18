Rails.application.routes.draw do
  get 'home/page'
  root 'home#page'
  resources :photos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
