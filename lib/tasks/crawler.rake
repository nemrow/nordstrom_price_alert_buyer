namespace :crawler do
  task :price_check => :environment do
    saved_items = SavedItem.where("active = ? and end_date > ?", true, Date.today)
    saved_items.each do |saved_item|
      browser = Browser.new(saved_item.vendor)
      price = browser.product.price_check(saved_item.product_url, saved_item.product_specs)
      if price <= saved_item.price
        browser = Browser.new(saved_item.vendor, saved_item.user)
        browser.account.sign_in
        puts "Signed In: #{browser.account.signed_in?}"
        puts saved_item.product_url
        browser.product.add_to_cart(saved_item.product_url, saved_item.product_specs) if browser.account.signed_in?
        puts "Signed In: #{browser.account.signed_in?}"
        browser.browser.mome
      end
    end
  end
end
