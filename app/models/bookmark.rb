class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # mapテーブルに変更があった際にgeocodeを実行させる
  after_validation :geocode

  private
  def geocode
    uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=[ここにAPIキー]")
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
