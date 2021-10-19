class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :destroy
  enum sale_status: {
    sale: 0,        # 販売中
    sold_out: 1,    # 売切れ
  }
  attachment :image, destroy: false
end
