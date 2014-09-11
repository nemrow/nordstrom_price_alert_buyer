require 'spec_helper'

describe Cart do
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

    @browser = SignIn.new(@user, @vendor).get_browser
  end

  context "when a user, vendor and browser are provided" do
    it "return the proper vendor class cart" do
      klass = Cart.new(@user, @browser, @vendor).get_cart
      assert_equal Nordstrom::Cart, klass
    end
  end
end
