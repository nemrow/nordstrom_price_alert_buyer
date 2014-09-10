class Nordstrom::AddToCart
  def initialize(user, browser)
    @user = user
    @browser = browser
  end

  def run(product_url, options={})
    go_to_product_page(product_url)
    specify_options(options)
    add_to_cart
    handle_backorder_confirmation
  end

  private
    def go_to_product_page(product_url)
      @browser.goto product_url
    end

    def specify_options(options)
      until @browser.button(:class => "option-label").exists? do sleep 1 end
      options.each do |option, value|
        if option == :size
          @browser.button(:class => "option-label", :value => value.upcase).fire_event('onclick')
        elsif option == :color
          @browser.select_list(:id => "color-selector").select(value)
        end
      end
    end

    def add_to_cart
      @browser.button(:id => "add-to-shopping-bag-button").click
    end

    def handle_backorder_confirmation
      if @browser.div(:class => "alert-message").exists? && @browser.div(:class => "alert-message").text == "Backordered Item:"
        @browser.button(:id => "ok-button").click
      end
    end
end
