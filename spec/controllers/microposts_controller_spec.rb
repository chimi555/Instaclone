require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  describe '#index' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end
      # ログインしていたら正常にレスポンスを返す
      it 'returns http success' do
        sign_in @user
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'as an user without logged in' do
      it 'redirect to login page' do
        get :new
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#create' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end
      # ログインしていたらmicropostを投稿できる
      it 'post a new micropost' do
        micropost_params = FactoryBot.attributes_for(:micropost)
        sign_in @user
        expect do
          post :create, params: { micropost: micropost_params }
        end.to change(@user.microposts, :count).by(1)
      end
    end

    context 'as an user without logged in' do
      it 'redirect to login page' do
        micropost_params = FactoryBot.attributes_for(:micropost)
        post :create, params: { micropost: micropost_params }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#new' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end
      # ログインしていたら正常にレスポンスを返す
      it 'returns http success' do
        sign_in @user
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'as an user without logged in' do
      it 'redirect to login page' do
        get :new
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  # describe "#show" do
  # context "as an authenticated user" do
  # before do
  # @user = FactoryBot.create(:user)
  # @micropost = FactoryBot.create(:micropost)
  # end
  # ログインしていたら正常にレスポンスを返す
  # it 'returns http success' do
  # sign_in @user
  # get :show, params: { id: @micropost.id }
  # expect(response).to have_http_status(:success)
  # end
  # end

  # context "as an user without logged in" do
  # it "redirect to login page" do
  # get :show
  # expect(response).to have_http_status "302"
  # expect(response).to redirect_to "/users/sign_in"
  # end
  # end
  # end

  describe '#destroy' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.build(:user)
        @micropost = FactoryBot.create(:micropost, owner: @user)
      end
      # 自分の投稿は削除できる
      it 'deletes a micropost' do
        sign_in @user
        expect do
          delete :destroy, params: { id: @micropost.id }
        end.to change(@user.microposts, :count).by(-1)
      end
      # 他人の投稿は削除できない
      it "can't delete the other user's micropost" do
        sign_in @other_user
        expect do
          delete :destroy, params: { id: @micropost.id }
        end.to_not change(@user.microposts, :count)
      end
    end

    context 'as an user without logged in' do
      before do
        @micropost = FactoryBot.create(:micropost)
      end
      it 'redirect to login page' do
        post :destroy, params: { id: @micropost.id }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end

      it "can't delete the micropost" do
        expect do
          delete :destroy, params: { id: @micropost.id }
        end.to_not change(Micropost, :count)
      end
    end
  end
end
