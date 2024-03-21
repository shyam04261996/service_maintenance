class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :service_id
      t.string :address
      t.string :description
      t.string :full_name
      t.string :mobile_number
      t.string :pincode
      t.integer :client_account_id
      t.string :status
      t.string :service_department
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.timestamps
    end
  end
end
