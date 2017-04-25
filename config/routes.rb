Rails.application.routes.draw do
  root to: 'application#index'
  post 'process-charge', to: 'application#process_charge'
end
