class Browser
  def initialize(vendor, user=nil, options={})
    @vendor = vendor
    @user = user
    @options = options
  end

  def browser
    @browser ||= begin
      browser = Watir::Browser.new(:phantomjs)
      browser.goto(@vendor.host) unless !@user
      browser
    end
  end

  def account
    raise "Must initialize with a user" if !@user
    @account ||= vendor_class::Account.new(@vendor, browser, @user, @options)
  end

  def product
    vendor_class::Product.new(@vendor, browser)
  end

  private
    def vendor_class
      @vendor_class ||= Kernel.const_get(@vendor.class_name)
    end
end
