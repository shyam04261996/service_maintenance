class AddStartAndEndTimeToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :start_time, :datetime
    add_column :accounts, :end_time, :datetime
  end
end
