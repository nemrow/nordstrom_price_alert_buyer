class Vendor < ActiveRecord::Base
  attr_accessible :host, :display_name, :class_name

  has_many :vendor_credentials
end
