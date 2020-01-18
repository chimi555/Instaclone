# frozen_string_literal: true

module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link 'Log in'
    fill_in 'メールアドレスまたはユーザーネーム', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'Log in'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
