class RemoveReferencesFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :references, :string
  end
end
