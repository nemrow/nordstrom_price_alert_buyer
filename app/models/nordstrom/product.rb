class Nordstrom::Product

  SHOPPING_CART_URL = "https://secure.nordstrom.com/shoppingbag.aspx?origin=tab"
  REMOVAL_BUTTON_IMAGE_URL = "https://secure.nordstromimage.com/images/Secure42/Remove_Button.gif"

  def initialize(vendor, browser)
    @vendor = vendor
    @browser = browser
  end

  def add_to_cart(product_url, product_specs=[])
    go_to_product_page(product_url)
    Nordstrom::ProductSpecSelector.new(product_specs).apply_product_specs(@browser)
    add_current_product_to_cart
    handle_backorder_confirmation
    @browser.mome
  end

  def price_check(product_url, product_specs=[])
    go_to_product_page(product_url)
    Nordstrom::ProductSpecSelector.new(product_specs).apply_product_specs(@browser)
    pricing_class.current_price(product_specs)
  end

  def remove_all_items_from_cart
    go_to_cart_page
    remove_all_cart_items
    until @browser.shopping_bag_count == 0 do sleep 1 end
  end

  def pricing_class
    @pricing_class ||= Nordstrom::Pricing.new(@browser)
  end

  private
    def go_to_product_page(product_url)
      @browser.goto product_url
      count = 0
      until @browser.section(:id => "customizations").exists?
        raise "can't loat product page" if count > 10
        sleep(1)
        count += 1
      end
    end

    def add_current_product_to_cart
      @browser.button(:id => "add-to-shopping-bag-button").click
    end

    def handle_backorder_confirmation
      if @browser.div(:class => "alert-message").exists? && @browser.div(:class => "alert-message").text == "Backordered Item:"
        @browser.button(:id => "ok-button").click
      end
    end

    def go_to_cart_page
      @browser.goto SHOPPING_CART_URL
    end

    def remove_all_cart_items
      @browser.wait_for_page_load
      removal_buttons = @browser.imgs(:src => REMOVAL_BUTTON_IMAGE_URL)
      removal_buttons.each do |button|
        button.click
      end
    end
end
