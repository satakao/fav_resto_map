class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :image

  validates :store_name, presence:true
  validates :description, presence:true,length:{maximum:100}
  validates :is_published, presence:true

end
