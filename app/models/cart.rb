class Cart < ApplicationRecord
  # A cart can contain multiple items.
  # Prevent deleting a cart if its items have not been removed.
  has_many :cart_items, dependent: :restrict_with_error

  # Provide access to all products through the cart's items.
  has_many :products, through: :cart_items

  # Every guest cart must have a unique identifier.
  validates :token, presence: true, uniqueness: true
end
