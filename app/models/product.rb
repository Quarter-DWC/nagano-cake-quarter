class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :destroy

  enum sale_status: {
    sale: 0,        # 販売中
    sold_out: 1,    # 売切れ
  }

  attachment :image, destroy: false

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: {only_integer: true}
  validates :genre_id, presence: true, numericality: {only_integer: true}

  #税込価格=税抜価格*1.1、小数点以下切り捨て
  def tax_included_price
    (price*1.1).floor
  end
end
