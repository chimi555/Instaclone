# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
    end

    context 'as an authenticated user' do
      it 'can follow the other_user' do
        sign_in @user
        expect do
          post :create, params: { followed_id: @other_user.id }
        end.to change(Relationship, :count).by(1)
      end
    end

    context 'as an user without logged in' do
      it "can't follow the other_user" do
        expect do
          post :create, params: { followed_id: @other_user.id }
        end.to_not change(Relationship, :count)
      end

      it 'redirect to login page' do
        post :create, params: { followed_id: @other_user.id }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#destroy' do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
    end

    context 'as an authenticated user' do
      before do
        sign_in @user
        @user.follow(@other_user)
        @relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
      end

      it 'can unfollow the other_user' do
        expect do
          delete :destroy, params: { id: @relationship.id }
        end.to change(Relationship, :count).by(-1)
      end
    end

    context 'as an user without logged in' do
      before do
        @relationship = FactoryBot.create(:relationship)
      end
      it "can't unfollow the other_user" do
        expect do
          delete :destroy, params: { id: @relationship.id }
        end.to_not change(Relationship, :count)
      end

      it 'redirect to login page' do
        delete :destroy, params: { id: @relationship.id }
        expect(response).to have_http_status '302'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
