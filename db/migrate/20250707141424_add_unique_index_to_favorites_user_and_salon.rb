class AddUniqueIndexToFavoritesUserAndSalon < ActiveRecord::Migration[6.1]
  def change
    add_index :favorites, [:user_id, :salon_id], unique: true
  end
end
