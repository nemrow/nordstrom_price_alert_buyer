class Browser
  def initialize(vendor)
    @vendor = vendor
  end

  def browser
    @browser ||= begin
      browser = Watir::Browser.new(:phantomjs)
      browser.goto(@vendor.host)
      browser
    end
  end

  def sign_in(user, options={})
    vendor_class::SignIn.new(@vendor, browser, user, options)
  end

  private
    def vendor_class
      @vendor_class ||= Kernel.const_get(@vendor.class_name)
    end
end
