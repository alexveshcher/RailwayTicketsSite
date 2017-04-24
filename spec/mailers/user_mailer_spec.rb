require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "send_to_admin" do
    let(:mail) { UserMailer.send_to_admin('user1@gmail.com', 'some subject', 'some name', 'tezdsfsdf') }

    # it "renders the headers" do
    #   expect(mail.subject).to eq("Signup")
    #   expect(mail.to).to eq(["to@example.org"])
    #   expect(mail.from).to eq(["from@example.com"])
    # end

    it "renders the body" do
      expect(mail.body.encoded).to match("<h2>User some name sent email for you </h2>")
    end
  end
end
