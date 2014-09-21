require 'spec_helper'

PRODUCT_PAGE_URL = "http://shop.nordstrom.com/s/tadashi-shoji-textured-lace-mermaid-gown/3452181"
PRODUCT_SALE_PAGE_URL = "http://shop.nordstrom.com/s/lush-print-cross-back-skater-dress-juniors/3859793"
PRODUCT_MULTI_DEPT_SALE_URL = "http://shop.nordstrom.com/s/max-mia-crinkled-maxi-skirt-regular-petite/3261791"

describe Product do
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

  context "For scraping prices without user credentials" do
    context "given a non sale price with multipe department product_specs" do
      it "should return the price of the product" do
        browser = Browser.new(@vendor, :skip_homepage => true)
        product_specs = [
          ProductSpec.create(:product_spec_type => "size", :value => "4"),
          ProductSpec.create(:product_spec_type => "color", :value => "Carmine"),
          ProductSpec.create(:product_spec_type => "department", :value => "regular")
        ]
        assert_equal 298.00, browser.product.price_check(PRODUCT_PAGE_URL, product_specs)
      end
    end

    context "given a sale price with one no department product_specs" do
      it "should return the price of the product" do
        browser = Browser.new(@vendor, :skip_homepage => true)
        product_specs = [
          ProductSpec.create(:product_spec_type => "size", :value => "small"),
          ProductSpec.create(:product_spec_type => "color", :value => "Navy Floral")
        ]
        assert_equal 22.98, browser.product.price_check(PRODUCT_SALE_PAGE_URL, product_specs)
      end
    end

    context "given a sale price with multi department product_specs" do
      it "should return the price of the product" do
        browser = Browser.new(@vendor, :skip_homepage => true)
        product_specs = [
          ProductSpec.create(:product_spec_type => "size", :value => "small"),
          ProductSpec.create(:product_spec_type => "color", :value => "Lipstick"),
          ProductSpec.create(:product_spec_type => "department", :value => "Petite")
        ]
        assert_equal 46.80, browser.product.price_check(PRODUCT_MULTI_DEPT_SALE_URL, product_specs)
      end
    end
  end
end
