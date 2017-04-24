class ContactsController < ApplicationController
  def new

  end

  def create
    @subject = contact_params[:subject]
    @name = contact_params[:name]
    @text = contact_params[:text]
    UserMailer.send_to_admin(current_user.email, @subject, @name, @text).deliver_now
  end

  def contact_params
	  params.require(:contact).permit(:name, :subject, :text)
  end

end
