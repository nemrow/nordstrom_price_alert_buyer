class Browser
  def initialize(vendor, specs={})
    @vendor = vendor
    @specs = specs
  end

  def browser
    @browser ||= begin
      browser = Watir::Browser.new(:phantomjs)
      browser.goto(@vendor.host) unless @specs[:skip_homepage]
      browser
    end
  end

  def account(specs={})
    raise "No User Initialized In ProductSpecs" if !@specs[:user]
    @account ||= vendor_class::Account.new(@vendor, browser, @specs)
  end

  def product
    vendor_class::Product.new(@vendor, browser)
  end

  private
    def vendor_class
      @vendor_class ||= Kernel.const_get(@vendor.class_name)
    end
end
