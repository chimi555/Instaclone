class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :picture, presence: true
  validate :picture_size
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  private

    #アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "shoule be less than 5MB")
      end
    end
end
