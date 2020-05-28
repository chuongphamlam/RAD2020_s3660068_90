class CreateCard < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :name
      t.integer :number
      t.string :photo
      t.timestamps
    end
  end
end
