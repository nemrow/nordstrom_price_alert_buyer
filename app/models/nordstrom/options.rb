module Nordstrom
  class Options
    def initialize(options={})
      @options = options
    end

    def apply_options(browser)
      browser.wait_for_page_load
      @options.each do |option, value|
        case option
        when :size then handle_size(browser, option, value)
        when :color then handle_color(browser, option, value)
        when :department then handle_department(browser, option, value)
        end
      end
    end

    private
      def handle_size(browser, option, value)
        size_button = browser.buttons(:class => "option-label").find {|b| b.value.match(/#{value}/i)}
        raise "Cannot find options button for #{option} - #{value}" if size_button.nil?
        size_button.fire_event('onclick')
      end

      def handle_color(browser, option, value)
        browser.select_list(:id => "color-selector").select(value)
      end

      def handle_department(browser, option, value)
        department_radio = browser.radios(:name => "price-filter").find {|b| b.value.match(/#{value}/i)}
        raise "Cannot find options button for #{option} - #{value}" if department_radio.nil?
        department_radio.click
      end
  end
end
