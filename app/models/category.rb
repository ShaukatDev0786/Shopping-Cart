class Category < ApplicationRecord
	# has_many :products: One category can contain multiple products.
	# dependent: :restrict_with_error: Prevents deleting a category that still has products.
  # presence: true: Category names cannot be blank.
  # uniqueness: true: Rails checks that the category name is not already used. The database unique index also protects against duplicates in concurrent requests.
	has_many :products, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true	
end
