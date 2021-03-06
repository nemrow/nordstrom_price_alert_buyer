module Nordstrom
  class Pricing
    def initialize(browser)
      @browser = browser
    end

    def current_price(product_specs=[])
      sale_price(product_specs) || regular_price(product_specs)
    end

    def sale_price(product_specs=[])
      @sale_price ||= begin
        price_spans = selected_pricing_row(product_specs).css('td.item-price span')
        if price_spans.count > 1
          price_extractor (price_spans.css('[class=sale-price]').text)
        elsif price_spans.count == 1
          price_extractor(price_spans.text)
        end
      end
    end

    def regular_price(product_specs=[])
      @regular_price ||= begin
        price_spans = selected_pricing_row(product_specs).css('td.item-price span')
        if price_spans.count > 1
          price_extractor (price_spans.css('[class=regular-price]').text)
        elsif price_spans.count == 1
          price_extractor(price_spans.text)
        end
      end
    end

    private
      def price_extractor(price_string)
        price = price_string.match(/(\$?\d+(?:[,.]?(?:\d{1,2}))?)/)[1]
        price.gsub!("$","")
        price.to_f
      end

      def pricing_node
        Nokogiri::HTML(@browser.section(:id => "price").html)
      end

      def pricing_rows
        pricing_node.css('tr.item-price-rows')
      end

      def selected_pricing_row(product_specs)
        return pricing_rows[0] if pricing_rows.count == 1
        department = product_specs.find{|ps| ps.product_spec_type == "department"}
        raise "No department type given where department type is mandatory" if !department
        pricing_rows.find do |price_row|
          price_row.css('input[name=price-filter]')[0]["value"] =~ /#{department.value}/i
        end
      end
  end
end
