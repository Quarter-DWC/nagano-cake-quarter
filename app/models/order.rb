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
  
  enum payment_method: {
    credit_card: 0,       #銀行振込
    transfer: 1           #クレジットカード
  }

  validates :postal_code, presence: true, length: { is: 7 }, numericality: {only_integer: true}
  validates :address, presence: true
  validates :address_name, presence: true
end
