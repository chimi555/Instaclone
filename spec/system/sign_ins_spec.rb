require 'rails_helper'

RSpec.describe 'Sign in', type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit login_path
  end

  describe 'valid user' do
    it 'success sign in' do
      fill_in 'メールアドレスまたはユーザーネーム', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_button 'Log in'
      expect(page).to have_current_path "/users/#{@user.id}"
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_link 'Log out', href: logout_path
      expect(page).to have_link href: users_path
      expect(page).to have_link href: user_path(@user)
      expect(page).to have_link href: notifications_path
    end
  end

  describe 'invalid user' do
    it 'failes sign in' do
      fill_in 'メールアドレスまたはユーザーネーム', with: ''
      fill_in 'パスワード', with: ''
      click_button 'Log in'
      expect(page).to have_current_path new_user_session_path
      expect(page).to have_content 'Invalid Login or password.'
    end
  end
end
