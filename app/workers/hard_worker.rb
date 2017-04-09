class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    UserMailer.welcome_email('username').deliver_now
  end
end
