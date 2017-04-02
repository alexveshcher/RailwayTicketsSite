class WelcomeController < ApplicationController
  def index
  end

  def send_email
    UserMailer.welcome_email('username').deliver_now
  end
end
