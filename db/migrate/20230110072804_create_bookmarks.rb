class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :customer_id, foreign_key: true, null: false
      t.integer :post_id, foreign_key: true, null: false
      t.timestamps
    end
  end
end
