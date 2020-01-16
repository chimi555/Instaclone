require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) {FactoryBot.build(:user)}
  let(:other_user) {FactoryBot.create(:user, name: "ExampleTestUser")}
  let(:active_relationship) {user.active_relationships.build(followed_id: other_user.id)}
  let(:passive_relationship) {user.passive_relationships.build(follower_id: other_user.id)}
 #有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(active_relationship).to be_valid
  end

  it 'has a valid factory' do
    expect(passive_relationship).to be_valid
  end

end
