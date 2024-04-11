class AddBookingIdAndPdfUrlToInvoices < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :booking_id, :bigint
    add_column :invoices, :pdf_url, :string
  end
end
