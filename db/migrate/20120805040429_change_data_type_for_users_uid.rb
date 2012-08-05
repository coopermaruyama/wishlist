class ChangeDataTypeForUsersUid < ActiveRecord::Migration
  def up
  	change_table :users do |t|
      t.change :uid, :string
    end
  end

  def down
  	change_table :users do |t|
      t.change :uid, :integer
    end
  end
end
