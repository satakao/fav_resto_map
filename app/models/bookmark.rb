class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # bookmarksテーブルに変更があった際にgeocodeを実行させる
  # after_validation :geocode
  validates :user_id, uniqueness: {scope: :post_id}

  private

  # def geocode
  #   uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=<%= ENV['GOOGLE_MAP_API_KEY'] %>")
  #   res = HTTP.get(uri).to_s
  #   response = JSON.parse(res)
  #   self.latitude = response["results"][0]["geometry"]["location"]["lat"]
  #   self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  # end
end
