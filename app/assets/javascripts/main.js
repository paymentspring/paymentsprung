$(document).ready(function()
{
  function callback(response)
  {
    var params = {
      amount: $('#amount').val(),
      token: response
    };

    $.ajax({
      url: '/process-charge',
      data: params,
      type: 'POST',
      success: function(response)
      {
        // update dom
        // --
        $('#response').html('<img src="https://media.giphy.com/media/eoxomXXVL2S0E/giphy.gif"/>Hey it worked! Good job.<div style="clear: both;"></div>');
        $('#response').removeClass('hidden');
      },
      error: function(response)
      {
        // update dom
        // --
        var error = JSON.parse(response.responseText);
        $('#response').html('<img src="https://media.giphy.com/media/3uyIgVxP1qAjS/giphy.gif"/>' + error.message + '<div style="clear: both;"></div>');
        $('#response').removeClass('hidden');
      }
    });
  }

  $('button').on('click', function()
  {
    // update dom
    // --
    $('#response').addClass('hidden');

    // data members
    // --
    var public_key = '';//<-- Please enter your PaymentSpring public API key here
    var card_holder = $('#card_holder').val();
    var card_number = $('#card_number').val();
    var csc = $('#csc').val();
    var exp_month = $('#exp_month').val();
    var exp_year = $('#exp_year').val();

    // execute
    // --
    paymentspring.generateToken(public_key, card_number, csc, card_holder, exp_month, exp_year, callback);
  });
});