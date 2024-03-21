class AddRoleToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :role, :string
  end
end
