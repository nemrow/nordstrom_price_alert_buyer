require 'spec_helper'

describe Browser do
  before(:each) do
    @user = User.create(
      :name => "Jordan Nemrow",
      :email => ENV["JORDAN_NORDSTROM_EMAIL"],
      :password => "password"
    )
    vendor_credential = VendorCredential.create(
      :username => ENV["JORDAN_NORDSTROM_EMAIL"],
      :password => ENV["JORDAN_NORDSTROM_PASSWORD"]
    )
    @vendor = Vendor.find_by_class_name("Nordstrom")
    vendor_credential.user = @user
    vendor_credential.vendor = @vendor
    vendor_credential.save
  end

  context "when correct credentials are given" do
    it "should return a browser with the user logged in" do
      browser = Browser.new(@vendor, :user => @user)
      browser.account.sign_in
      browser.account.signed_in?.should be(true)
    end
  end
end
