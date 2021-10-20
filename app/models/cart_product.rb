class CartProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :quantity, presence: true

  # 商品ごとの小計
  def subtotal_price
    product.price * quantity
  end

  # 商品全体の合計金額
  def self.total_price
    self.pluck(:quantity, :price).sum{ |q, p| q * p }
  end

end
