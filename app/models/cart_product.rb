class CartProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :quantity, presence: true

  # 商品ごとの小計
  def subtotal_price
    product.tax_included_price * quantity
  end

  # 商品全体の合計金額
  def self.total_price
    result = 0
    carts = self.all
    carts.each do |cart|
      result += cart.subtotal_price
    end
    return result
  end

end
