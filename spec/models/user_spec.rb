require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :user_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_length_of(:user_name).is_at_most(50) }
  it { is_expected.to validate_length_of(:profile).is_at_most(140) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:user_name).case_insensitive }

  # アドレスのフォーマット検証
end
