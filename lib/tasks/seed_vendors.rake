namespace :vendors do
  task :seed => :environment do
    vendors = YAML.load_file("#{Rails.root}/db/fixtures/vendors.yml")
    vendors.each do |vendor|
      Vendor.find_or_create_by_class_name(vendor).update_attributes(vendor)
    end
  end
end
