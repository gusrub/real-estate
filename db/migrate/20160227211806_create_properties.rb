class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.text :description
      t.text :photo
      t.decimal :price, precision: 12, scale: 2
      t.string :street_number
      t.string :street_name
      t.string :suite
      t.string :zipcode
      t.string :city
      t.references :state, index: true, foreign_key: true
      t.references :agent, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
