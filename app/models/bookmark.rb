class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # bookmarksテーブルに変更があった際にgeocodeを実行させる
  # after_validation :geocode
  validates :user_id, uniqueness: {scope: :post_id}

end
