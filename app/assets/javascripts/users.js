/* global $, Stripe */
//Doucument ready.
$(document).on('turbolinks.load', function(){
  var theForm = $("#pro_form");
  var submitBtn = $("#form-submit-btn");
  
  //Set stripe public key.
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr("content") );
  
  //When user click form submit button.
  submitBtn.click(function(event){
    //prevent default submission behavior.default.
    event.preventDefault();
    
    submitBtn.val("Processing...").prop('disabled', true);
    
    //Collect the credit cards fields.
    var ccNum = $("#card_number").val(),
      cvcNum = $("#card_code").val(),
      expMonth = $("#cardMonth").val(),
      expYear = $("#cardYear").val();
      
      //Use stripe js library to check card error
      var error = false;
      
      //Validate card number
      if(!Stripe.card.validateCardNumber(ccNum) ) {
        error = true;
        alert("Credit card Number appears to be invalid");
      }
      
      //Validate cvc number
      if(!Stripe.card.validateCVC(cvcNum) ) {
        error = true;
        alert("The cvc number appears to be invalid");
      }
      
      //Validate expiration date
      if(!Stripe.card.validateExpiry(expMonth, expYear) ) {
        error = true;
        alert("The expiry date appears to be invalid");
      }
      
      if (error) {
        //If there are card errors don't send the stripe
        submitBtn.prop('disabled', false).val("Sign Up");
      }else {
        //Send card informatopn to Strip.
        Stripe.createToken( {
          number: ccNum,
          cvc: cvcNum,
          exp_Month: expMonth,
          exp_Year: expYear
        }, stripeResponseHandler );
      }
      
      return false;
  });
    
    //Strip will return card token.
    function stripeResponseHandler(status, response) {
      //Get the token
      var token = response.id;
      
      //Inject card token as hidden field into form.
      theForm.append($('<input type="hidden" name="user[stripe_card_token]">').val(token) );
      
      //Submit form into our rails app.
      theForm.get(0).submit();
      
    }
    
});
