class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :title
      t.string :phone
      t.string :mobile
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
