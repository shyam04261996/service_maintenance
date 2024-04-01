class UpdateBookingsTableForServiceDepartmentArray < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :service_department
    add_column :bookings, :service_departments, :string, array: true, default: []
    add_column :bookings, :prize, :string
  end
end
