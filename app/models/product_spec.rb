class ProductSpec < ActiveRecord::Base
  attr_accessible :saved_item_id, :product_spec_type, :value

  belongs_to :saved_item
end
