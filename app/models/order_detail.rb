class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  enum make_status: {
    disable_cooking: 0,   # 着手不可
    before_cooking: 1,    # 制作待ち
    now_cooking: 2,       # 制作中
    complete_cooking: 3,  # 制作完了
  }

  validates :quantity, presence: true

  # 商品ごとの小計
  def subtotal_price
    product.tax_included_price * quantity
  end
end
