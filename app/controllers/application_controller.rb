class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # The PaymentSpring API expects an integer representation in cents, so we call
  #    this method before sending any amounts
  def to_cents(amount)
    (amount.to_f * 100).to_i
  end

end
