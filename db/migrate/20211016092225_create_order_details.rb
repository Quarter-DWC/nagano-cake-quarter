class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :order_id,      null: false, default: ""
      t.integer :product_id,    null: false, default: ""
      t.integer :quantity,      null: false, default: ""
      t.integer :make_status,   null: false, default: 0
      t.timestamps
    end
  end
end
