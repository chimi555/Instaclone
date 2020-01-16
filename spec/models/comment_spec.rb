require 'rails_helper'

RSpec.describe Comment, type: :model do
  #有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:comment)).to be_valid
  end

  it {is_expected.to validate_presence_of :content}
end
