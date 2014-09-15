class Product
  def initialize(user, vendor, browser)
    @user = user
    @vendor = vendor
    @browser = browser
  end

  def get_cart
    vendor_class = Kernel.const_get(@vendor.class_name)
    vendor_class::Product.new(@user, @vendor, @browser)
  end
end
