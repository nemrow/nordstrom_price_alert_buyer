class User < ActiveRecord::Base
  attr_accessible :email, :name, :nordstrom, :nordstrom_cc_cvc, :nordstrom_email, :nordstrom_password, :password

  has_secure_password
end
