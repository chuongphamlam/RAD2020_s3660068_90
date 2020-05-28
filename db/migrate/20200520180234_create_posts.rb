class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :forum_id
      t.text :content
      t.string :title
      t.integer :counter, default: 0
      t.string:photo
      t.timestamps
    end
  end
end
