class Product < ApplicationRecord
  # belongs_to :category  Every product belongs to a category
  # Name validation - Product name is required
  # Price validation - Price cannot be negative
  # Stock validation - Stock must be a non-negative integer
  # active scope  Finds products currently available for listing
  # in_stock scope - Finds products with available inventory
  belongs_to :category
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  scope :active, -> { where(active: true) }
  scope :in_stock, -> { where("stock > 0") }
end
