class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :topic
      t.text :content
      t.integer :category_id, :index => true

      t.timestamps null: false
    end
  end
end
