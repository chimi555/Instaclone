require 'rails_helper'

RSpec.describe "Sign up", type: :system do
  before do
    visit root_path
    click_link "新規登録"
  end

  context "valid user" do
    it "success sign up" do
      expect {
        fill_in '名前', with: "Example User"
        fill_in 'ユーザーネーム', with: "ExampleUser_username"
        fill_in 'メールアドレス', with: "example@example.com"
        fill_in 'パスワード', with: "foobar"
        fill_in 'パスワード(確認)', with: "foobar"
        click_button "新規登録"
      }.to change(User,:count).by(1)
      expect(page).to have_content "Welcome! You have signed up successfully."
    end
  end
end