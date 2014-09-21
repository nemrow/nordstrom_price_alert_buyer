class CreateSavedItems < ActiveRecord::Migration
  def change
    create_table :saved_items do |t|
      t.integer :user_id
      t.integer :vendor_id
      t.decimal :price, :precision => 8, :scale => 2
      t.text :product_url
      t.string :product_url_checksum
      t.boolean :active, :default => true
      t.date :end_date
      t.date :purchase_date

      t.timestamps
    end
  end
end
