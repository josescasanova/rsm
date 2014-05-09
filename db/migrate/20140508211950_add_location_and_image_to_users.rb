class AddLocationAndImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_url, :string
    add_column :users, :location, :string
  end
end
