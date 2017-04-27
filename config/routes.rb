Rails.application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'home'

  post 'charge-card', to: 'application#charge_card'
  post 'create-customer', to: 'application#create_customer'
end
