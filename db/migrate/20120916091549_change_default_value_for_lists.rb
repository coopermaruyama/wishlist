class ChangeDefaultValueForLists < ActiveRecord::Migration
  def up
  	change_column :lists, :balance, :decimal, :precision => 8, :scale => 2
  end

  def down
  	change_column :lists, :balance, :decimal, :precision => 8, :scale => 2, :default => 0.00
  end
end
