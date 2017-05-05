class CustomersController < ApplicationController

  def create

    # define params
    parameters = {
      basic_auth: {
        username: Rails.application.secrets.private_api_key,
        password: ''
      },
      body: {
        company: params[:company],
        first_name: params[:first_name],
        last_name: params[:last_name],
        address_1: params[:address],
        city: params[:city],
        state: params[:state],
        zip: params[:zip],
        country: params[:country],
        phone: params[:phone],
        fax: params[:fax],
        website: params[:website],
        card_number: params[:card_number],
        card_exp_month: params[:card_exp_month],
        card_exp_year: params[:card_exp_year]
      }
    }

    # point request at paymentspring
    url = 'https://api.paymentspring.com/api/v1/customers'

    # send the request
    response = HTTParty.send(:post, url, parameters)

    # parse response
    if response['errors'] && response['errors'].count
      render status: 500, json: response['errors'].first
    else
      render plain: "Success!"
    end
  end

  def results
    # define params
    parameters = {
      basic_auth: {
        username: Rails.application.secrets.private_api_key,
        password: ''
      },
      body: {
        search_term: params[:query]
      }
    }

    # point request at paymentspring
    url = 'https://api.paymentspring.com/api/v1/customers/search'

    # send the request
    response = HTTParty.send(:post, url, parameters)

    if response['errors'] && response['errors'].count
      render status: 500, json: response['errors'].first
    else
      # parse response
      body = JSON.parse(response.body, symbolize_names: true)
      @total_results = body[:meta][:total_results]
      @customers = body[:list]
    end
  end
end
