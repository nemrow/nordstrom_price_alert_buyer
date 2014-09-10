class Watir::Browser
  def shopping_bag_count
    ['shoppingBagCount', 'shopping-bag-count'].each do |class_name|
      return self.span(:id => class_name).text.to_i if self.span(:id => class_name).exists?
    end
  end

  def wait_for_page_load
    count = 0
    until self.img(:alt => /nordstrom/i).exists? do
      raise "Page Load Failed! Shit." if count > 10
      sleep 1
      count += 1
    end
  end
end
