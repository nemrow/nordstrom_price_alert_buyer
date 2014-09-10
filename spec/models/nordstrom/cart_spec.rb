require 'spec_helper'

describe Nordstrom::Cart do
  before(:each) do
    @user = User.create(
      :name => "Jordan Nemrow",
      :email => ENV["JORDAN_NORDSTROM_EMAIL"],
      :password => "password",
      :nordstrom_email => ENV["JORDAN_NORDSTROM_EMAIL"],
      :nordstrom_password => ENV["JORDAN_NORDSTROM_PASSWORD"],
      :nordstrom_cc_cvc => ENV["JORDAN_NORDSTROM_CC_CVC_CODE"]
    )
    @browser = Nordstrom.browser
    Nordstrom::SignIn.new(@user, @browser).run
  end

  describe "being able to add products to the cart for a user already signed in" do

    it "should add item to cart" do
      product_url = "http://shop.nordstrom.com/s/tahari-seamed-a-line-dress-regular-petite/3501047"
      @browser.wait_for_page_load
      original_cart_count = @browser.shopping_bag_count
      Nordstrom::Cart.new(@user, @browser).add_to_cart(product_url, {:size => "2", :color => "Red"})
      assert_equal original_cart_count + 1, @browser.shopping_bag_count
    end
  end

  describe "being able to remove all items from a users cart" do
    before(:each) do
      product_url = "http://shop.nordstrom.com/s/tahari-seamed-a-line-dress-regular-petite/3501047"
      Nordstrom::Cart.new(@user, @browser).add_to_cart(product_url, {:size => "2", :color => "Red"})
    end

    it "should remove all items from cart" do
      Nordstrom::Cart.new(@user, @browser).remove_all_items_from_cart
      assert_equal 0, @browser.shopping_bag_count
    end
  end
end
