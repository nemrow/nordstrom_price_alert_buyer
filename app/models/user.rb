class User < ActiveRecord::Base
  attr_accessible :email, :name, :password

  has_secure_password

  validates :email, uniqueness: true

  has_many :vendor_credentials
end
