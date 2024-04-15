ActiveAdmin.register BxBlockTermsandconditions::TermAndCondition, as: "Terms And Condition" do
  actions :all
  permit_params :title, :description

  index do
    selectable_column
    id_column
    column :title
    column :description
    actions
  end

  filter :title

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
    end
    f.actions
  end
end
