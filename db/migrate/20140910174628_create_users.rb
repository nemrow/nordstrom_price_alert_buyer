class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :nordstrom_email
      t.string :nordstrom_password
      t.integer :nordstrom_cc_cvc

      t.timestamps
    end
  end
end
