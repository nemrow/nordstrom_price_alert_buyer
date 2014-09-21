class VendorCredential < ActiveRecord::Base
  attr_accessible :user_id, :vendor_id, :username, :password, :password_digest

  belongs_to :user
  belongs_to :vendor

  validates :vendor_id, :uniqueness => {:scope => :user_id}

  def password=(password)
    self.password_digest = AESCrypt.encrypt(password, ENV["AESCRYPT_PASSWORD"])
  end

  def password
    AESCrypt.decrypt(self.password_digest, ENV["AESCRYPT_PASSWORD"])
  end

  def self.authenticate_credentials(user, credentials)
    vendor = Vendor.find(credentials[:vendor_id])
    browser = Browser.new(vendor, user, {:credentials => OpenStruct.new(credentials)})
    browser.account.sign_in
    browser
  end
end
