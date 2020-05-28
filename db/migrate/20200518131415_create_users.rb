class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :photo
      t.string :mobile
      t.string :city
      t.string :intro
      t.timestamps
    end
  end
end
