class ChargesController < ApplicationController
  def charge_card
    # create body for tokenization
    body = {
      token_type: 'credit_card',
      card_owner_name: params[:card_holder],
      card_number: params[:card_number],
      card_exp_month: params[:exp_month],
      card_exp_year: params[:exp_year],
      csc: params[:csc]
    }

    # generate token
    token_id = generate_token(body)

    # define params
    parameters = {
      basic_auth: {
        username: Rails.application.secrets.private_api_key,
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
      render plain: 'Success!'
    end
  end

  def charge_bank

    # create body for tokenization
    body = {
      token_type: 'bank_account',
      bank_account_number: params[:bank_account_number],
      bank_routing_number: params[:bank_routing_number],
      bank_account_holder_first_name: params[:first_name],
      bank_account_holder_last_name: params[:last_name],
      bank_account_type: params[:bank_account_type].downcase!
    }

    # generate token
    token_id = generate_token(body)

    # define params
    parameters = {
      basic_auth: {
        username: Rails.application.secrets.private_api_key,
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
      render plain: 'Success!'
    end
  end

  private

  def generate_token(body)

    # define params
    parameters = {
      basic_auth: {
        username: Rails.application.secrets.public_api_key,
        password: ''
      },
      body: body
    }
    # point request at paymentspring
    url = 'https://api.paymentspring.com/api/v1/tokens'

    # send the request to generate the token
    response = HTTParty.send(:post, url, parameters)

    # grab token
    body = JSON.parse(response.body)
    body['id']
  end

  def to_cents(amount)
    (amount.to_f * 100).to_i
  end

end
