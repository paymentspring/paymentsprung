# PaymentSprung

PaymentSprung is a sample app demonstrating PaymentSpring's API.

## [1. Getting Started](#Getting-Started)

### Getting Started

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
