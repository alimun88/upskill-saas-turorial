class ContactsController < ApplicationController
  def new
   @contact = Contact.new
  end
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      firstname = params[:contact][:first_name]
      lastname = params[:contact][:last_name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      ContactMailer.contact_email(firstname, lastname, email, body).deliver
      flash[:success] = "Message Sent Successsfully"
      redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  private
  def contact_params
     params.require(:contact).permit(:first_name, :last_name, :email, :comments)
  end
end
