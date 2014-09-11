require 'spec_helper'

describe Vendor do
  before(:each) do
    @credential = FactoryGirl.create(:vendor_credential)
  end

  it "should have correct associations" do
    vendor = Vendor.find_by_class_name("Nordstrom")
    vendor.vendor_credentials << @credential
    vendor.vendor_credentials.should include(@credential)
  end
end
