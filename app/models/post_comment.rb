class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, length:{maximum:300}
end
