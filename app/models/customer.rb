class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :kana_first_name, presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :phone_number, presence: true, length: { minimum: 10 }, numericality: {only_integer: true}
  validates :postal_code, presence: true, length: { is: 7 }, numericality: {only_integer: true}
  validates :address, presence: true
  validates :is_valid, presence: true

  # フルネーム表示
  def full_name
    last_name + " " + first_name
  end

  def kana_full_name
    kana_last_name + " " + kana_first_name
  end

end
