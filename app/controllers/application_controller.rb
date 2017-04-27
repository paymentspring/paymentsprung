class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  def process_charge

    # generate token
    token_id = generate_token('credit_card', params[:card_holder], params[:card_number], params[:exp_month], params[:exp_year], params[:csc])

    # define params
    parameters = {
      basic_auth: {
        username: '', #<-- insert your private API key between the single quotes
        password: '' 
      },
      body: {
        token: token_id,
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



  def create_customer

    # define params
    parameters = {
      basic_auth: {
        username: '',
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
        phone: params[:phone]
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
      render status: 200, json: { success: true }
    end
  end

  private

  def generate_token(token_type, card_owner_name, card_number, card_exp_month, card_exp_year, csc)

    # define params
    parameters = {
      basic_auth: {
        username: '', #TODO: Think of a smarter way to handle API keys...
        password: ''
      },
      body: {
        token_type: token_type,
        card_owner_name: card_owner_name,
        card_number: card_number,
        card_exp_month: card_exp_month,
        card_exp_year: card_exp_year,
        csc: csc
      }
    }

    # point request at paymentspring
    url = 'https://api.paymentspring.com/api/v1/tokens'

    # send the request to generate the token
    response = HTTParty.send(:post, url, parameters)

    # grab token
    body = JSON.parse(response.body)
    token_id = body['id']
  end

  def to_cents(amount)
    (amount.to_f * 100).to_i
  end
end
