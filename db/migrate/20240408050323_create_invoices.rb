class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.bigint :order_id
      t.string :invoice_number
      t.date :invoice_date
      t.float :total_amount
      t.string :company_address
      t.string :company_city
      t.string :company_zip_code
      t.string :company_phone_number
      t.string :bill_to_name
      t.string :bill_to_company_name
      t.string :bill_to_address
      t.string :bill_to_city
      t.string :bill_to_zip_code
      t.string :bill_to_phone_number
      t.string :bill_to_email
      t.string :service_department_name
      t.float :service_unit_price

      t.timestamps
    end
  end
end
