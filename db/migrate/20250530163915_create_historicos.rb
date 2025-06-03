class CreateHistoricos < ActiveRecord::Migration[8.0]
  def change
    create_table :historicos do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity_change
      t.string :action_type
      t.string :user
      t.text :note

      t.timestamps
    end
  end
end
