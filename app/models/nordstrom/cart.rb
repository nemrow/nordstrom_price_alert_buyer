class Nordstrom::Cart

  SHOPPING_CART_URL = "https://secure.nordstrom.com/shoppingbag.aspx?origin=tab"
  REMOVAL_BUTTON_IMAGE_URL = "https://secure.nordstromimage.com/images/Secure42/Remove_Button.gif"

  def initialize(user, browser)
    @user = user
    @browser = browser
  end

  def add_to_cart(product_url, options={})
    go_to_product_page(product_url)
    specify_product_options(options)
    add_current_product_to_cart
    handle_backorder_confirmation
  end

  def remove_all_items_from_cart
    go_to_cart_page
    remove_all_cart_items
    until @browser.shopping_bag_count == 0 do sleep 1 end
  end

  private
    def go_to_product_page(product_url)
      @browser.goto product_url
    end

    def specify_product_options(options)
      @browser.wait_for_page_load
      options.each do |option, value|
        if option == :size
          @browser.button(:class => "option-label", :value => value.upcase).fire_event('onclick')
        elsif option == :color
          @browser.select_list(:id => "color-selector").select(value)
        end
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
