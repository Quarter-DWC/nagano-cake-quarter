class Product < ApplicationRecord
  has_many :order_details
  has_many :cart_prodaucts

  attachment :image, destroy: false
  enum sale_status: {販売中:0,売切れ:1}
end
