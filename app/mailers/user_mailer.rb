class UserMailer < ApplicationMailer
  default from: 'railwaytickets@gmail.com'

  def tickets_email(user_email, tickets)
    @user = user_email
    @tickets = tickets
    mail(to: @user, subject: 'We found tickets you requested')
  end
end
