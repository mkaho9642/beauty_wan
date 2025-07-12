class CreateSalonGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :salon_genres do |t|
      t.references :salon, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
