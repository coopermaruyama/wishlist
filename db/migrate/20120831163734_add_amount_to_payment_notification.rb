class AddAmountToPaymentNotification < ActiveRecord::Migration
  def change
    add_column :payment_notifications, :amount, :integer
  end
end
