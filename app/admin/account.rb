ActiveAdmin.register AccountBlock::Account, as: "Account" do
  actions :all
  permit_params :first_name, :last_name, :email, :full_phone_number, :role, :password, :activated 

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :full_phone_number
    column :role
    actions
  end

  filter :email
  filter :full_name

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :full_phone_number
      f.input :password
      f.input :role, as: :select, collection: ['User','Employee', 'Client']
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :full_phone_number
      row :role
      # Add more rows for other attributes as needed
    end

    panel "Availability" do
      table_for account.availabilities do
        column :id
        column :start_time
        column :end_time
        column :remark
        column :description
      end
    end
  end
end
