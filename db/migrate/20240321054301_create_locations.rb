class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.float :longitude
      t.float :latitude
      t.integer :employee_account_id
      t.integer :client_account_id
      t.string :description
      t.string :town
      t.integer :service_id
      t.string :postal_code

      t.timestamps
    end
  end
end
