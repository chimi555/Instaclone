# frozen_string_literal: true

FactoryBot.define do
  factory :micropost do
    content { 'Micropost text' }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    association :owner
  end
end
