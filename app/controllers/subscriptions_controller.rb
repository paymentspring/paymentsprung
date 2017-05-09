class SubscriptionsController < ApplicationController
  def create
    # define params
    parameters = {
      basic_auth: {
        username: Rails.application.secrets.private_api_key,
        password: ''
      },
      body: {
        id: params[:id],
        customer_id: params[:customer_id],
        ends_after: params[:ends_after]
      }
    }

    # point request at paymentspring
    url = "https://api.paymentspring.com/api/v1/plans/#{params[:id]}/subscription/#{params[:customer_id]}"

    # send the request
    response = HTTParty.post(url, parameters)

    # parse response
    if response.success?
      render plain: 'Success!'
    elsif response.parsed_response.nil? || response.parsed_response == 'Not Found'
      render plain: 'Error: Response not found'
    else
      render json: JSON.parse(response.body)
    end
  end
end
