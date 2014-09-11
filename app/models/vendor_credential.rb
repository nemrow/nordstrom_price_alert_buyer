class VendorCredential < ActiveRecord::Base
  attr_accessible :user_id, :vendor_id, :username, :password, :password_digest

  belongs_to :user
  belongs_to :vendor

  def password=(password)
    self.password_digest = AESCrypt.encrypt(password, ENV["AESCRYPT_PASSWORD"])
  end

  def password
    AESCrypt.decrypt(self.password_digest, ENV["AESCRYPT_PASSWORD"])
  end
end
