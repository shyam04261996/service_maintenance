class AddTotalAmountAndDiscountAmountToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :total_amount, :decimal
    add_column :bookings, :discount_amount, :decimal
    add_column :bookings, :price, :decimal
  end
end
