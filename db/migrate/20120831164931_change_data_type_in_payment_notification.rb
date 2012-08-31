class ChangeDataTypeInPaymentNotification < ActiveRecord::Migration
  def up
  	change_column :payment_notifications, :amount, :decimal
  end

  def down
  	change_column :payment_notifications, :amount, :integer
  end
end
