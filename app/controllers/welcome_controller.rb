class WelcomeController < ApplicationController
  def index
  end

  def send_email
    HardWorker.perform_in(30.seconds)
  end
end
