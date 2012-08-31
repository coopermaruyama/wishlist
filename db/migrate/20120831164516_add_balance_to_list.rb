class AddBalanceToList < ActiveRecord::Migration
  def change
    add_column :lists, :balance, :decimal, :default => 0.00
  end
end
