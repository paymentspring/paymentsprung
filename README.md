# PaymentSprung

PaymentSprung is a sample app used to demonstrate how easy it is to integrate PaymentSpring's API into an existing Rails project.

## [1. Getting Started](#Getting-Started)

### Getting Started

PaymentSprung requires Rails v5 or higher to run properly. To start, clone this repo wherever you'd like:

`git clone https://github.com/nspenner/payment_sprung.git`

PaymentSprung only requires two modifications before it will run properly. First, you'll need to grab your [PaymentSpring API keys](https://manage.paymentspring.com/account), which can be found at the bottom of your account page on PaymentSpring's dashboard. If you don't have a PaymentSpring account yet, what are you waiting for? It's free!

**Note: you may need to regenerate your keys, as your private API key is only shown upon generation for security purposes.**

After you've grabbed your API keys, two lines of code in the project will need to be updated before PaymentSprung will correctly process payments to your account. First, open `/app/controller/application_controller.rb` and insert your private API key under the params method:

```ruby
# define params
    parameters = {
      basic_auth: {
        username: '', #<-- insert your private API key between the single quotes
        password: '' 
      },
```

Next, we'll insert the public API key under `/app/assets/javascripts/main.js`. Insert your public API key under the data members section:

```javascript
// data members
    // --
    var public_key = '';//<-- insert your public API key between the single quotes
    var card_holder = $('#card_holder').val();
    var card_number = $('#card_number').val();
    var csc = $('#csc').val();
    var exp_month = $('#exp_month').val();
    var exp_year = $('#exp_year').val();
```

Now we're ready to start PaymentSprung and make some payments! Make sure you are in your root directory, and run the following commands:

```bash
bundle install
rails server
```

Provided that no error messages display, you should be able to point your web browser at `http://localhost:3000` and see the landing page. Congratulations, you are ready to make payments.