require 'spec_helper'

describe SignIn do
  before(:each) do
    @user = User.new(
      :name => "Jordan Nemrow",
      :email => ENV["JORDAN_NORDSTROM_EMAIL"]
    )
    @user.password = "password"
    vendor_credential = VendorCredential.create(
      :username => ENV["JORDAN_NORDSTROM_EMAIL"],
      :password => ENV["JORDAN_NORDSTROM_PASSWORD"]
    )
    @vendor = Vendor.find_by_class_name("Nordstrom")
    vendor_credential.user = @user
    vendor_credential.vendor = @vendor
    vendor_credential.save
  end

  context "when a user and vendor is provided" do
    it "return the proper vendor class for signing in" do
      browser = SignIn.new(@user, @vendor).get_browser
      browser.span(:id => 'shopperGreeting').text.should match(/Jordan/)
    end
  end
end
