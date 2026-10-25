class CreateCarts < ActiveRecord::Migration[8.1]
  def change
    create_table :carts do |t|
      # A unique token identifies a guest's shopping cart without requiring login.
      t.string :token, null: false

      t.timestamps
    end

    # Prevent multiple carts from sharing the same token.
    add_index :carts, :token, unique: true
  end
end
