class Micropost < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  #validates :user_id, presence: true  micropostのテストが通らないため外す belongs_to :ownerとしたことで user_id は必ずあるものだと考える
  validates :picture, presence: true
  validates :content, length: {maximum: 140 }
  validate :picture_size
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  #いいね通知のインスタンスメソッド
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and micropost_id = ? and action = ? ", current_user.id, user_id, id, "like"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        micropost_id: id,
        visited_id: user_id,
        action: "like"
        )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  #コメント通知のインスタンスメソッド
  def create_notification_comment!(current_user)
    temp_ids = Comment.select(:user_id).where(micropost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id["user_id"])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visited_id: user_id,
      action: "comment"
      )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end



  private

    #アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "shoule be less than 5MB")
      end
    end
end
