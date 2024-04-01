class RollbackUpdateBookingsTableForServiceDepartmentArray < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :service_department, :string
    remove_column :bookings, :prize
    remove_column :bookings, :service_departments
  end
end
