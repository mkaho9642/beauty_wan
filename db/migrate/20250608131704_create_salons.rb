class CreateSalons < ActiveRecord::Migration[6.1]
  def change
    create_table :salons do |t|
      t.integer :genre_id
      t.integer :review_id
      t.string :name
      t.text :introduction
      t.timestamps
    end
  end
end
