class AddDiscountPercentageToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :discount_percentage, :integer
  end
end
