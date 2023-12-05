class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null:false
      t.string :store_name, null:false
      t.text :description, null:false
      t.float :latitude, null:false
      t.float :longitude, null:false
      t.string :address, null:false
      t.boolean :is_published, null:false, defalt: false
      t.timestamps
    end
  end
end
