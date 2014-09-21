namespace :vendors do
  task :seed => :environment do
    vendors = YAML.load_file("#{Rails.root}/db/fixtures/vendors.yml")
    vendors.each do |vendor|
      Vendor.find_or_create_by_class_name(vendor).update_attributes(vendor)
    end
  end

  task :test_saved_item_data => :environment do
    raise "ONLY FOR DEVELOPMENT!" if Rails.env != "development"
    SavedItem.destroy_all
    ProductSpec.destroy_all
    vendor = Vendor.find_or_create_by_class_name("Nordstrom")
    user = User.first
    saved_item_yaml_data = YAML.load_file("#{Rails.root}/db/fixtures/test_saved_item_yaml_data.yml")
    saved_item_yaml_data.each do |item|
      si = SavedItem.create(
        :price => item[:price],
        :product_url => item[:product_url],
        :end_date => Date.today + 1.days
      )
      user.saved_items << si
      si.vendor = vendor
      si.save
      item[:product_specs].each do |o|
        o.each do |product_spec_type, value|
          product_spec = ProductSpec.create(
            :product_spec_type => product_spec_type,
            :value => value
          )
          si.product_specs << product_spec
        end
      end
    end
  end
end
