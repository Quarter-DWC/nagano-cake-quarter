class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {
    credit_card: 0,       # クレジットカード
    transfer: 1           # 銀行振込
  }

  enum order_status: {
    not_payment: 0,       # 入金待ち
    confirm_payment: 1,   # 入金確認
    now_cooking: 2,       # 制作中
    now_packing: 3,       # 発送準備中
    complete_send: 4      # 発送済み
  }

  validates :postal_code, presence: true, length: { is: 7 }, numericality: {only_integer: true}
  validates :address, presence: true
  validates :address_name, presence: true

  # 商品合計（送料別）
  def uninclude_fee_price
    (total_price - fee).to_s(:delimited)
  end

end
