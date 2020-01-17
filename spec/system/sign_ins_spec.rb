require 'rails_helper'

RSpec.describe "Sign in", type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
  end

  it "user signs in"do
    fill_in 'メールアドレスまたはユーザーネーム', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_button "Log in"
    expect(page).to have_current_path "/users/#{@user.id}"
  end
end