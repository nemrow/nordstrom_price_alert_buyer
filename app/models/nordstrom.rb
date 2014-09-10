module Nordstrom
  def self.browser
    browser = Watir::Browser.new(:phantomjs)
    browser.goto "http://shop.nordstrom.com"
    browser
  end
end
