class AddPremiumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :premium, :datetime
  end
end
