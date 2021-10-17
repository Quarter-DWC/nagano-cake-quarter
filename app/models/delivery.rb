class Delivery < ApplicationRecord
  belongs_to :customer

  validates :postal_code, presence: true, length: { is: 7 }, numericality: {only_integer: true}
  validates :address, presence: true
  validates :address_name, presence: true
end
