class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.string :castle, null: false
      t.text :body, null: false
      t.boolean :is_published_flag, default: true

      t.timestamps
    end
  end
end
