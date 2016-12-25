/* global $, Stripe, stripeResponseHandler */
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
    
    //Collect the credit cards fields.
    var ccNum = $("#card_number").val(),
      cvcNum = $("#card_code").val(),
      expMonth = $("#cardMonth").val(),
      expYear = $("#cardYear").val();
        
    //Send card informatopn to Strip.
      Stripe.createToken( {
        number: ccNum,
        cvc: cvcNum,
        exp_Month: expMonth,
        exp_Year: expYear
      }, stripeResponseHandler );
  });
    
    //Strip will return card token.
    //Inject card token as hidden field into form.
    //Submit form into our rails app.
});
