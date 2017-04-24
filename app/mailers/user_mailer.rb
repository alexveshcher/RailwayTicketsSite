class UserMailer < ApplicationMailer
  default from: 'railwaytickets@gmail.com'

  def tickets_email(user_email, tickets)
    @user = user_email
    @tickets = tickets
    mail(to: @user, subject: 'We found tickets you requested')
  end

  def send_to_admin(user_email, subject, name, text)
    @name = name
    @text = text
    mail(from: user_email ,  to: 'admin@admin.com', subject: subject)
  end
end
