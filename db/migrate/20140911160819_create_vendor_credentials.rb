class CreateVendorCredentials < ActiveRecord::Migration
  def change
    create_table :vendor_credentials do |t|
      t.integer :user_id
      t.integer :vendor_id
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
