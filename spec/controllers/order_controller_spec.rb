require "rails_helper"

describe "guest access", type: :request do
    it "requires login" do
      get order_new_path
      expect(response).to redirect_to new_user_session_path
    end
end

describe 'GET order#new', type: :request do
    context 'when user is logged in' do
      user = FactoryGirl.create(:user)
      before do
        sign_in user
        get order_new_path
      end
      it { expect(response).to have_http_status(200) }
    end
end
