require 'rails_helper'

RSpec.describe "User edit", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    sign_in_as(@user)
  end

#  it "an authenticated user can edit user info" do
#    click_link "プロフィール編集"
#    expect(page).to have_current_path "/users/edit"
#    fill_in "名前", with: "EditName"
#    fill_in "ユーザーネーム", with: "Edit_username"
#    fill_in "メールアドレス", with: "edit@example.com"
#    click_button "Update"
#    expect(page).to have_current_path "/users/#{@user.id}"
#    expect(user.reload.name).to eq "EditName"
#    expect(user.reload.user_name).to eq "Edit_username"
#    expect(user.reload.email).to eq "edit@example.com"
#  end

#一旦保留

end