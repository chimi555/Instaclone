# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :login
  attr_accessor :current_password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         authentication_keys: [:login]
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
  validates :profile, length: { maximum: 140 }

  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :liked_microposts, through: :likes, source: :micropost
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification',
                                  foreign_key: 'visitor_id',
                                  dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification',
                                   foreign_key: 'visited_id',
                                   dependent: :destroy

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      email: auth.info.email,
      name: auth.info.name,
      password: Devise.friendly_token[0, 20],
      image: auth.info.image
    )

    user
  end

  def login
    @login || user_name || email
  end

  # ログイン認証の条件をオーバーライド
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(user_name) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:user_name) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def feed
    following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def already_liked?(micropost)
    liked_microposts.include?(micropost)
  end

  def like(micropost)
    likes.create(micropost_id: micropost.id)
  end

  def unlike(micropost)
    likes.find_by(micropost_id: micropost.id).destroy
  end

  # フォロー通知のインスタンスメソッド
  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
