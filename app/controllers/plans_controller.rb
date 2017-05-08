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

  def subscribe
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
    url = 'https://api.paymentspring.com/api/v1/plans/' + params[:id].to_s +
          '/subscription/' + params[:customer_id].to_s

    # send the request
    response = HTTParty.send(:post, url, parameters)
    # parse response
    if response.code == 201
      render plain: 'Success!'
    elsif response.parsed_response.nil? || response.parsed_response == 'Not Found'
      render plain: 'Error: Response not found'
    else
      render json: JSON.parse(response.body)
    end
  end
end
