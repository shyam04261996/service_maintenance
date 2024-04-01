class AddPriceToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :price, :decimal
  end
end
