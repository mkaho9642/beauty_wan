class CreateAdminGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_genres do |t|

      t.timestamps
    end
  end
end
