class UserMailer < ApplicationMailer
  default from: 'sender@email.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'reciever@email.com', subject: 'Letter Subject')
  end
end
