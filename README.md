# PaymentSprung

PaymentSprung is a sample app demonstrating PaymentSpring's API.

## Getting Started

PaymentSprung requires Rails v5 or higher to run properly. To start, clone this repo wherever you'd like:

`git clone https://github.com/paymentspring/paymentsprung.git`

Before PaymentSprung will run correctly, you'll need to grab your [PaymentSpring API keys](https://manage.paymentspring.com/account), which can be found at the bottom of your account page on PaymentSpring's dashboard. If you don't have a PaymentSpring account yet, what are you waiting for? It's free!

**Note: you may need to regenerate your keys, as your private API key is only shown upon generation for security purposes.**

After you've grabbed your API keys, you'll need to insert them into `/config/secrets.yml`:

```Ruby
development:
  secret_key_base: ...
  private_api_key: # Insert your private API key here
  public_api_key: # Insert your public API key here
```

Now we're ready to start PaymentSprung! Make sure you are in your root directory, and run the following commands:

```bash
bundle install
rails server
```

Provided that no error messages display, you should be able to point your web browser at `http://localhost:3000` and see the landing page.

## Integrating PaymentSpring Into Your Sites

We designed PaymentSprung as an example of how to integrate the PaymentSpring API into Rails Apps. Nearly every function on this sample app was created with the same process. To demonstrate this, we'll run through one of the requests: Creating a Customer.

First, we'll take a look at the CustomersController, which handles requests dealing with Customers. Go ahead and open `app/controllers/customer_controller.rb`. The method we are concerned with in this case is `create`:
```Ruby
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
```
Let's break down this method into smaller pieces. First, we have to define our parameters:
```Ruby
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
```
We use basic_auth to verify the account by grabbing the API key stored in `/config/secrets.yml`. Next, using the PaymentSpring API as a guide, we need to create the body for our request by grabbing the fields from the `app/views/customers/new.html.erb` view and assigning them to their corresponding values as outlined [here](https://paymentspring.com/developers/#create-a-customer). You'll notice in this case that they already match up quite well with the input forms from our view. Now we point and send the API call:
```Ruby
# point request at paymentspring
url = 'https://api.paymentspring.com/api/v1/customers'

# send the request
response = HTTParty.send(:post, url, parameters)
```
We use the [HTTParty gem](https://github.com/jnunemaker/httparty) to make this process much easier. `url` points to the `/customers` part of PaymentSpring's API, and we `POST` our request with our parameters and get a response back. Finally, we parse the response:
```Ruby
# parse response
if response['errors'] && response['errors'].count
  render status: 500, json: response['errors'].first
else
  render plain: "Success!"
end
```
We render a `json` error response if the request didn't go through. Otherwise, we render a view displaying "Success!". Granted, this functionality could be a little more robust – we could implement a `show` view for customers and direct the browser to the newly created page if we wanted. Still, we thought this got the point across!

## Next Steps
If you are interested in integrating the PaymentSpring API into your site, take a look at some of the other methods on the sample app as well; they implement similar functionality. If you still have any questions or feedback about using the API, [drop us a line](https://paymentspring.com/contact/). We'd love to hear from you!