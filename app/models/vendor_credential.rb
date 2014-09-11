class VendorCredential < ActiveRecord::Base
  attr_accessible :user_id, :vendor_id, :password, :username

  has_secure_password

  belongs_to :user
  belongs_to :vendor
end
