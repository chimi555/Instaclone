require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end
      it 'returns http success' do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'as an user without logged in' do
      before do
        @user = FactoryBot.create(:user)
      end
      it 'redirect to login page' do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET #index' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end
      it 'returns http success' do
        sign_in @user
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'as an user without logged in' do
      it 'redirect to login page' do
        get :index
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
