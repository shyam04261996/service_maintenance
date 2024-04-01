ActiveAdmin.register BxBlockLocation::Location, as: "Location" do
  actions :all
  permit_params :address, :city, :state, :country

  index do
    selectable_column
    id_column
    column :address
    column :city
    column :state
    column :country
    column :pincode
    actions
  end

  form do |f|
    f.inputs do
      f.input :address
      f.input :city
      f.input :state
      f.input :country
      f.input :mobile_number
      f.input :pincode
    end
    f.actions
  end
end
