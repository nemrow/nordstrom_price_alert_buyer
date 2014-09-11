require 'spec_helper'

describe VendorCredential do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @vendor = Vendor.find_by_class_name("Nordstrom")
  end

  it "should have correct associations" do
    credentials = VendorCredential.create(:username => "my_nordstrom_email", :password => "my_nordstrom_password")
    credentials.vendor = @vendor
    credentials.user = @user
    credentials.save
    assert_equal @user, credentials.user
    assert_equal @vendor, credentials.vendor
  end
end
