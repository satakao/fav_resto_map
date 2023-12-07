class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  #フォローする際の記述
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #フォローフォロワー一覧表示する記述
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_one_attached :profile_image
 
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  
  GUEST_USER_EMAIL = "guest@example.com"
  
  # ゲストユーザー情報の検索、なければ作成して渡す
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  #フォローする時の処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #フォロー外す時の処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end
  
end