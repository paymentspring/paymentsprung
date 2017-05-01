Rails.application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'home'

  post 'charge-card', to: 'application#charge_card'
  post 'charge-bank', to: 'application#charge_bank'
  post 'create-customer', to: 'application#create_customer'
  post 'search-customers', to: 'application#search_customers'
end
