ActiveAdmin.register BxBlockService::Service, as: "Service" do
  actions :all

  permit_params :full_name, :start_time, :end_time, :address, :service_department, :status, :price

  form do |f|
    f.inputs "Service Details" do
      f.input :full_name
      f.input :start_time
      f.input :end_time
      f.input :address
      f.input :service_department, as: :select, collection: BxBlockService::Service.service_departments.keys.map { |key| [BxBlockService::Service.human_attribute_name("service_department.#{key}"), key] }
      f.input :price
      f.input :status, as: :select, collection: ['Pending', 'Confirmed', 'Cancelled', 'In Progress', 'Completed']
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :full_name
    column :service_department do |service|
      BxBlockService::Service.human_attribute_name("service_department.#{service.service_department}")
    end
    column :start_time
    column :end_time
    column :address
    column :description 
    column :price
    column :status
    actions
  end
end
