class User < ActiveRecord::Base
  attr_accessible :email, :name, :password

  has_secure_password

  has_many :vendor_credentials
end
