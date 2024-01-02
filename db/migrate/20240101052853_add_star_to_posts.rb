class AddStarToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :star, :float
  end
end
