# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :content, presence: true
  has_many :notifications, dependent: :destroy
end
