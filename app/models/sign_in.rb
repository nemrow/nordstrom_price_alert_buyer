class SignIn
  def initialize(user, vendor)
    @user = user
    @vendor = vendor
  end

  def get_browser
    vendor_class = Kernel.const_get(@vendor.class_name)
    vendor_class::SignIn.new(@user, @vendor).run
  end
end
