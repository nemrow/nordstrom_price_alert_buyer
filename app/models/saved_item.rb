class SavedItem < ActiveRecord::Base
  attr_accessible :active, :end_date, :price, :product_url, :product_url_checksum, :purchase_date, :user_id

  belongs_to :user
  belongs_to :vendor
  has_many :product_specs
end
