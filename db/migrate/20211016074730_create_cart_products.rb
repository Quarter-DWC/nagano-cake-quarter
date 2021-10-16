class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|
      t.integer  :customer_id,   null: false, default: ""
      t.integer  :product_id,    null: false, default: ""
      t.integer  :quantity,      null: false, default: ""

      t.timestamps
    end
  end
end
