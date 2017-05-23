$(document).ready(function()
{
  function callback(response)
  {
    var params = {
      amount: $( '#amount' ).val(),
      token: response
    };

    $.ajax({
      url: '/charges/charge-card',
      data: params,
      type: 'POST',
      success: function(data) {
        $( '#response ').removeClass().addClass('w3-card w3-teal');
        $( '#response' ).append('Success! Transaction status: ' + data.status);
      },
      error: function(data) {
        var error = JSON.parse(data.responseText);
        $ ( '#response ').removeClass().addClass('w3-card w3-red');
        $ ( '#response' ).append('Error: ' + error.code + ': ' + error.message);
      }
    });
  }

  $( '#card_form' ).on( 'submit', function(event)
  {

    // Clear any previous responses
    $( '#response' ).empty();

    // Form submit events don't play nice with jsonp callbacks, so we prevent default behavior
    event.preventDefault();

    // Grab data from form
    var public_key = 'test_7b9056ac57145c1738cdd1aab370c9942189d18233a6208e8ad45dff44';
    var card_holder = $( '#card_holder' ).val();
    var card_number = $( '#card_number' ).val();
    var csc = $( '#csc' ).val();
    var exp_month = $( '#exp_month' ).val();
    var exp_year = $( '#exp_year' ).val();

    // Generate token
    paymentspring.generateToken(public_key, card_number, csc, card_holder, exp_month, exp_year, callback);
  });
});