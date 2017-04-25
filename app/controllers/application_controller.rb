class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  def process_charge

    # define params
    parameters = {
      basic_auth: {
        username: '', #<-- insert your private API key between the single quotes
        password: '' 
      },
      body: {
        token: params['token']['id'],
        amount: to_cents(params['amount'])
      }
    }

    # point the request at paymentspring
    url = 'https://api.paymentspring.com/api/v1/charge'

    # send the request to make the charge
    response = HTTParty.send(:post, url, parameters)

    # parse response
    if response['errors'] && response['errors'].count
      render status: 500, json: response['errors'].first
    else
      render status: 200, json: { success: true }
    end
  end
  
  private

  def to_cents(amount)
    (amount.to_f * 100).to_i
  end
end
