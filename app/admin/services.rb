ActiveAdmin.register BxBlockService::Service, as: "Service" do
  actions :all

  permit_params :full_name, :start_time, :end_time, :address, :service_department, :status

  form do |f|
    f.inputs "Service Details" do
      f.input :full_name
      f.input :start_time
      f.input :end_time
      f.input :address
      f.input :service_department
      f.input :status
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :full_name
    column :service_department
    column :start_time
    column :end_time
    column :address
    column :description # This column might be causing the extra field in index view
    column :status
    actions
  end
end
