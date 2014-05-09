class AddTokenAndSecretToUsers2 < ActiveRecord::Migration
  def change
    add_column :users, :consumer_token, :string
    add_column :users, :consumer_secret, :string
  end
end
