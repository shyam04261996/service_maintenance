ActiveAdmin.register BxBlockBooking::Booking, as: "Booking" do
  actions :all
  permit_params :start_time, :end_time, :service_id, :status, :address, :description, :full_name, :mobile_number, :pincode, :service_department

  index do
    selectable_column
    id_column
    column :full_name
    column :service_department
    column :address
    column :description
    column :mobile_number
    column :status
    column :price
    column :discount_amount
    column :total_amount
    column :status
    actions
  end

  form do |f|
    f.inputs do
      f.input :full_name
      f.input :start_time
      f.input :end_time
      f.input :address
      f.input :description
      f.input :mobile_number
      f.input :pincode
      f.input :service_department
      f.input :status
    end
    f.actions
  end
end
