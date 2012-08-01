class ChangeDataTypeForLineItemsProductId < ActiveRecord::Migration
  def up
  	change_table :line_items do |t|
  		t.change :product_id, :string
  	end
  end

  def down
  	change_table :line_items do |t|
  		t.change :product_id, :integer
  	end
  end
end
