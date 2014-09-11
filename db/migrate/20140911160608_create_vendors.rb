class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :host
      t.string :display_name
      t.string :class_name

      t.timestamps
    end
  end
end
