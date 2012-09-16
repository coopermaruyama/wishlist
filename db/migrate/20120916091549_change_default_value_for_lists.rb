class ChangeDefaultValueForLists < ActiveRecord::Migration
  def up
  	add_column :lists, :balance, :decimal, :precision => 8, :scale => 2
  end

  def down
  	remove_column :lists, :balance, :decimal, :precision => 8, :scale => 2, :default => 0.00
  end
end
