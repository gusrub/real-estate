class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.decimal :comission, precision: 4, scale: 2
      t.string :phone
      t.string :mobile
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
