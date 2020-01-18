require 'rails_helper'

RSpec.describe Micropost, type: :model do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:micropost)).to be_valid
  end

  it { is_expected.to validate_presence_of :picture }
  it { is_expected.to validate_length_of(:content).is_at_most(140) }
end
