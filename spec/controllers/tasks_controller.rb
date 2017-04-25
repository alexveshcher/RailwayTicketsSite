require "rails_helper"

describe "guest access", type: :request do
    it "requires login" do
      get tasks_list_path
      expect(response).to redirect_to new_user_session_path
    end
end

describe 'GET tasks#list', type: :request do
    context 'when admin is logged in' do
      admin = FactoryGirl.create(:admin)
      before do
        sign_in admin
        get tasks_list_path
      end
      it { expect(response).to have_http_status(200) }
    end
end

describe 'GET tasks#list', type: :request do
    context 'when user is logged in' do
      user = FactoryGirl.create(:user)
      before do
        sign_in user
        get tasks_list_path
      end
      it { expect(response).not_to have_http_status(200) }
    end
end
