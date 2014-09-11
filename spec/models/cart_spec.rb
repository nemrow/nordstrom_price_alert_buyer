require 'spec_helper'

describe Cart do
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

    @browser = SignIn.new(@user, @vendor).get_browser
  end

  context "when a user, vendor and browser are provided" do
    it "return the proper vendor class cart" do
      klass = Cart.new(@user, @vendor, @browser).get_cart
      assert_equal Nordstrom::Cart, klass.class
    end

    it "should add item to cart" do
      product_url = "http://shop.nordstrom.com/s/tahari-seamed-a-line-dress-regular-petite/3501047"
      @browser.wait_for_page_load
      original_cart_count = @browser.shopping_bag_count
      Cart.new(@user, @vendor, @browser).get_cart.add_to_cart(product_url, {:size => "2", :color => "Red"})
      assert_equal original_cart_count + 1, @browser.shopping_bag_count
    end

    describe "being able to remove all items from a users cart" do
      before(:each) do
        product_url = "http://shop.nordstrom.com/s/tahari-seamed-a-line-dress-regular-petite/3501047"
        Cart.new(@user, @vendor, @browser).get_cart.add_to_cart(product_url, {:size => "2", :color => "Red"})
      end

      it "should remove all items from cart" do
        Cart.new(@user, @vendor, @browser).get_cart.remove_all_items_from_cart
        assert_equal 0, @browser.shopping_bag_count
      end
    end
  end
end
