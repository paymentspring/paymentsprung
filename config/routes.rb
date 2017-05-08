Rails.application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'home'

  get 'charges/card'
  post 'charges/charge-card', to: 'charges#charge_card'
  get 'charges/bank'
  post 'charges/charge-bank', to: 'charges#charge_bank'
  get 'customers/new'
  post 'customers/create', to: 'customers#create'
  post 'customers/results', to: 'customers#results'
  get 'customers/search'
  get 'customers/show', to: 'customers#show'
  get 'plans/new'
  post 'plans/create'
end
