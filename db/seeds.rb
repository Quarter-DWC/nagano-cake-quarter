# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Admin.new(
  email: "test@test.com",
  password: "tester123")

admin.save!

Product.create!(
  genre_id: 1,
  name: "ショートケーキ",
  introduction: "美味しいケーキです",
  price: 280,
  image_id: "1",
  sale_status: 0)

Genre.create!(
  [
    {
      name: "ケーキ"
    },
    {
      name: "焼き菓子"
    },
    {
      name: "キャンディ"
    },
    {
      name: "プリン"
    }
  ])

customer = Customer.new(
  last_name: "山田",
  first_name: "太郎",
  kana_last_name: "ヤマダ",
  kana_first_name: "タロウ",
  email: "yamada@test.com",
  phone_number: "00000000000",
  postal_code: "0000000",
  address: "東京都",
  password: "test123",
  is_valid: true
  )

customer.save!

Order.create!(
  customer_id: 1,
  payment_method: 0,
  fee: 800,
  total_price: 1080,
  postal_code: "0000000",
  address: "東京都",
  address_name: "山田太郎",
  order_status: "0"
  )

OrderDetail.create!(
  order_id: 1,
  product_id: 1,
  quantity: 1,
  make_status: 0,
  )

CartProduct.create!(
  customer_id: 1,
  product_id: 1,
  quantity: 1,
  )

Delivery.create!(
  customer_id: 1,
  postal_code: "1230000",
  address: "大阪府",
  address_name: "山田次郎"
  )