require 'spec_helper'

describe Nordstrom::AddToCart do
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
    @browser.screenshot.save("spec/screenshots/text_0.png")
    Nordstrom::SignIn.new(@user, @browser).run
  end

  it "should add item to cart" do
    product_url = "http://shop.nordstrom.com/s/tahari-seamed-a-line-dress-regular-petite/3501047"
    @browser.screenshot.save("spec/screenshots/text_1.png")
    original_cart_count = @browser.span(:id => "shopping-bag-count").text.to_i
    Nordstrom::AddToCart.new(@user, @browser).run(product_url, {:size => "2", :color => "Red"})
    @browser.screenshot.save("spec/screenshots/text_2.png")
    assert_equal original_cart_count + 1, @browser.span(:id => "shopping-bag-count").text.to_i
  end
end
