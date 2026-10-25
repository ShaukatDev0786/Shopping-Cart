class CartItem < ApplicationRecord
  # Each item belongs to one cart and one product.
  belongs_to :cart
  belongs_to :product

  # A cart item must have a valid positive quantity.
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  # Store a non-negative unit price using decimal arithmetic.
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  # The same product should have only one row in a cart.
  # Adding the product again should increase its quantity.
  validates :product_id, uniqueness: { scope: :cart_id }
end
