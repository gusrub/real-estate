class AddFavoriteToCustomerProperties < ActiveRecord::Migration
  def change
    add_column :customer_properties, :favorite, :boolean
  end
end
