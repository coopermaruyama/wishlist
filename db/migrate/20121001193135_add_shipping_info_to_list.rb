class AddShippingInfoToList < ActiveRecord::Migration
  def change
    add_column :lists, :full_name, :string
    add_column :lists, :address1, :string
    add_column :lists, :address2, :string
    add_column :lists, :city, :string
    add_column :lists, :state, :string
    add_column :lists, :zip_code, :string
    add_column :lists, :phone_number, :string
  end
end
