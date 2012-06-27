class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.string :category
      t.string :name

      t.timestamps
    end
  end
end
