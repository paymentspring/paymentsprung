class PlansController < ApplicationController
  def create
    # define params
    parameters = {
      basic_auth: {
        username: Rails.application.secrets.private_api_key,
        password: ''
      },
      body: {
        frequency: params[:frequency].downcase!,
        name: params[:name],
        amount: to_cents(params[:amount]),
        day: params[:day]
      }
    }

    # point request at paymentspring
    url = 'https://api.paymentspring.com/api/v1/plans'

    # send the request
    response = HTTParty.send(:post, url, parameters)

    # parse response
    if response['errors'] && response['errors'].count
      render status: 500, json: response['errors'].first
    else
      render plain: 'Success!'
    end
  end
end
