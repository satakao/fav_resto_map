class Post < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, source: :tag

  has_one_attached :image

  # 自動でgeocodeをaddressが保存された際にaddressに対して実行する
  geocoded_by :address
  after_validation :geocode

  validates :store_name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 100 }
  # validates :is_published, presence:true
  validates :address, presence: true, length: { minimum: 2, maximum: 50 }
  validates :image, presence: true

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  def self.bookmarked_post(user) # モデル内での操作を開始
    includes(:bookmarks) # post_favorites テーブルを結合
      .where(bookmarks: { user_id: user.id }) # ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc) # 投稿を作成日時の降順でソート
  end

  def tag_names=(tag_names)
    self.tags = tag_names.map { |name| Tag.find_or_create_by(name:) }
  end

  # Method to retrieve tag names as a comma-separated string
  def tag_names
    tags.map(&:name).join(', ')
  end

  # 新しいタグの保存
  def save_tag(sent_tags)
    current_tags = tags.pluck(:name) unless tags.nil?

    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    Tag.where(name: old_tags).destroy_all

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      tags << new_post_tag
    end
  end

  def self.valid_looks(word)
    return unless word.present?

    @post = Post.where(is_published: true).where('store_name LIKE ?', "#{word}%")
  end

  def self.looks(word)
    return unless word.present?

    @post = Post.where('store_name LIKE ?', "#{word}%")
  end
end
