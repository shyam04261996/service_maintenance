class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
    t.integer :account_id
    t.string :service_department
    t.string :description
    t.datetime :start_time
    t.datetime :end_time
    t.string :status
    t.string :full_name
    t.string :address
    t.decimal :latitude, precision: 10, scale: 6
    t.decimal :longitude, precision: 10, scale: 6
    t.timestamps
    end
  end
end
