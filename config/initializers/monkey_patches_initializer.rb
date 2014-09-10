Dir.glob("#{Rails.root}/lib/monkey_patches/*.rb").each do |file|
  require file
end
