Rails.application.routes.draw do
  # post 'creators/create'
  resources :payments
  resources :gigs
  resources :creators
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
