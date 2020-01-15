# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # 名前、ユーザーネーム、メールアドレス、パスワードがあれば有効な状態であること
  it 'is valid with a name, email address, and password' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 名前がなければ無効
  it 'is invalid without a name' do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  # ユーザーネームがなければ無効
  it 'is invalid without a username' do
    user = FactoryBot.build(:user, user_name: nil)
    user.valid?
    expect(user.errors[:user_name]).to include("can't be blank")
  end

  # メールアドレスがなければ無効
  it 'is invalid without an email address' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # パスワードがなければ無効
  it 'is invalid without a password' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効
  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:user, email: 'chinami@example.com')
    user = FactoryBot.build(:user, email: 'chinami@example.com')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  #重複したユーザーネームなら無効
  it 'is invalid with a duplicate username' do
    FactoryBot.create(:user, user_name: 'chinami')
    user = FactoryBot.build(:user, user_name: 'chinami')
    user.valid?
    expect(user.errors[:user_name]).to include('has already been taken')
  end

  #名前が51文字以上だと登録できない
  it 'is invalid with a name too long' do
    user = FactoryBot.build(:user, name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end

  #ユーザーネームが51文字以上だと登録できない
  it 'is invalid with a username too long' do
    user = FactoryBot.build(:user, user_name: "a" * 51)
    user.valid?
    expect(user.errors[:user_name]).to include("is too long (maximum is 50 characters)")
  end

  # パスワードが5文字以下だと登録できない
  it 'is invalid with a password that shoter than 5 charactors' do
    user = FactoryBot.build(:user, password: "a" * 5 )
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  #自己紹介が141文字以上だと登録できない
  it 'is invalid with a password that longer than 141 charactors' do
    user = FactoryBot.build(:user, profile: "a" * 141 )
    user.valid?
    expect(user.errors[:profile]).to include("is too long (maximum is 140 characters)")
  end

  # アドレスのフォーマット検証
  # name email 長さ検証
end
