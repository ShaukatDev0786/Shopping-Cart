class CreateCartItems < ActiveRecord::Migration[8.1]
  def change
    create_table :cart_items do |t|
      # Associate this item with the shopping cart it belongs to.
      t.references :cart, null: false, foreign_key: true

      # Identify the product added to the shopping cart.
      t.references :product, null: false, foreign_key: true

      # Default to one unit when a customer adds a product.
      t.integer :quantity, null: false, default: 1

      # Preserve the unit price recorded when the product is added.
      t.decimal :unit_price, precision: 12, scale: 2, null: false

      t.timestamps
    end

    # Keep one row per product in each cart; update quantity instead of duplicating rows.
    add_index :cart_items, [ :cart_id, :product_id ], unique: true

    # Prevent zero or negative quantities at the database level.
    add_check_constraint :cart_items,
                         "quantity > 0",
                         name: "cart_items_quantity_positive"

    # Prevent negative prices at the database level.
    add_check_constraint :cart_items,
                         "unit_price >= 0",
                         name: "cart_items_unit_price_nonnegative"
  end
end
