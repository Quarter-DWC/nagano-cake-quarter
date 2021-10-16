class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

      t.integer :genre_id,     null: false, default: ""
      t.string  :name,         null: false, default: ""
      t.text    :introduction, null: false, default: ""
      t.integer :price,        null: false, default: ""
      t.string  :image_id,     null: false, default: ""
      t.integer :sale_status,  null: false, default: 0
      t.timestamps
    end
  end
end
