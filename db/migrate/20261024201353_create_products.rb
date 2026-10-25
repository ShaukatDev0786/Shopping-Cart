class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 12, scale: 2, null: false
      t.integer :stock, null: false, default: 0
      t.boolean :active, null: false, default: true

      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_check_constraint :products,
                         "price >= 0",
                         name: "products_price_nonnegative"

    add_check_constraint :products,
                         "stock >= 0",
                         name: "products_stock_nonnegative"

    add_index :products, :name
  end
end
