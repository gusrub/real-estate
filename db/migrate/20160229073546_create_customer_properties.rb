class CreateCustomerProperties < ActiveRecord::Migration
  def change
    create_table :customer_properties do |t|
      t.references :customer, index: true, foreign_key: true
      t.references :property, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
