class Browser
  def initialize(vendor, options={})
    @vendor = vendor
    @options = options
  end

  def browser
    @browser ||= begin
      browser = Watir::Browser.new(:phantomjs)
      browser.goto(@vendor.host) unless @options[:skip_homepage]
      browser
    end
  end

  def sign_in(user, options={})
    vendor_class::SignIn.new(@vendor, browser, user, options)
  end

  def product
    vendor_class::Product.new(@vendor, browser)
  end

  private
    def vendor_class
      @vendor_class ||= Kernel.const_get(@vendor.class_name)
    end
end
