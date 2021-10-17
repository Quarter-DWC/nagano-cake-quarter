class Product < ApplicationRecord
  has_many :order_details
  has_many :cart_prodaucts

  attachment :image, destroy: false
end
