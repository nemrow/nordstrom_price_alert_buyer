require 'spec_helper'

describe SignIn do
  before(:each) do
    @user = User.create(
      :name => "Jordan Nemrow",
      :email => ENV["JORDAN_NORDSTROM_EMAIL"],
      :password => "password"
    )
    @vendor_credential = VendorCredential.create(
      :username => ENV["JORDAN_NORDSTROM_EMAIL"],
      :password => ENV["JORDAN_NORDSTROM_PASSWORD"]
    )
    @vendor = Vendor.find_by_class_name("Nordstrom")
    @vendor_credential.user = @user
    @vendor_credential.vendor = @vendor
    @vendor_credential.save
  end

  context "when a user and vendor is provided" do
    it "return the proper vendor class for signing in" do
      klass = SignIn.new(@user, @vendor).get_browser
      assert_equal Nordstrom::SignIn, klass
    end
  end
end
