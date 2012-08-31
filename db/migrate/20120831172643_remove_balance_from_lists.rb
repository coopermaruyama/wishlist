class RemoveBalanceFromLists < ActiveRecord::Migration
  def up
    remove_column :lists, :balance
      end

  def down
    add_column :lists, :balance, :decimal
  end
end
