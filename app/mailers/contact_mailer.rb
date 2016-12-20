class ContactMailer < ActionMailer::Base
  default to: 'ayon88@hotmail.com'  
  
  def contact_email(firstname, lastname, email, body)
    @firstname = firstname
    @lastname = lastname 
    @email = email
    @body = body
    
    mail(from: email, subject: "Contact form Message")
  end
end