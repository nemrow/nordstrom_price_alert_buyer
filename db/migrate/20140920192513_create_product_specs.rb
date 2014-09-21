class CreateProductSpecs < ActiveRecord::Migration
  def change
    create_table :product_specs do |t|
      t.string :product_spec_type
      t.string :value
      t.integer :saved_item_id

      t.timestamps
    end
  end
end
