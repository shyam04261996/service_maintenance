class CreateAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.string :start_time
      t.string :end_time
      t.string :unavailable_start_time
      t.string :unavailable_end_time
      t.string :availability_date
      t.jsonb :timeslots
      t.integer :available_slots_count
      t.string :status
      t.string :remark
      t.string :description
      t.integer :account_id
      t.integer :service_id
      t.integer :booking_id

      t.timestamps
    end
  end
end
