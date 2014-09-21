module Nordstrom
  class ProductSpecSelector
    def initialize(product_specs=[])
      @product_specs = product_specs
    end

    def apply_product_specs(browser)
      browser.wait_for_page_load
      @product_specs.each do |product_spec|
        case product_spec.product_spec_type
        when "size" then handle_size(browser, product_spec)
        when "color" then handle_color(browser, product_spec)
        when "department" then handle_department(browser, product_spec)
        end
      end
    end

    private
      def handle_size(browser, product_spec)
        size_button = browser.buttons(:class => "option-label").find {|b| b.value.match(/#{product_spec.value}/i)}
        raise "Cannot find product_specs button for #{product_spec.product_spec_type} - #{product_spec.value}" if size_button.nil?
        size_button.fire_event('onclick')
      end

      def handle_color(browser, product_spec)
        browser.select_list(:id => "color-selector").select(product_spec.value)
      end

      def handle_department(browser, product_spec)
        department_radio = browser.radios(:name => "price-filter").find {|b| b.value.match(/#{product_spec.value}/i)}
        raise "Cannot find product_specs button for #{product_spec.product_spec_type} - #{product_spec.value}" if department_radio.nil?
        department_radio.click
      end
  end
end
