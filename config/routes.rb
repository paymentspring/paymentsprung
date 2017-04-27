Rails.application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'home'

  post 'process-charge', to: 'application#process_charge'
  post 'create-customer', to: 'application#create_customer'
end
