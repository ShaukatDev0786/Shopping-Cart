# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


electronics = Category.find_or_create_by!(name: "Electronics") do |category|
  category.description = "Electronic devices and accessories"
end

fashion = Category.find_or_create_by!(name: "Fashion") do |category|
  category.description = "Clothing and fashion accessories"
end

books = Category.find_or_create_by!(name: "Books") do |category|
  category.description = "Books and learning materials"
end

[
  {
    name: "Wireless Headphones",
    description: "Wireless headphones with clear sound",
    price: 1999.00,
    stock: 25,
    category: electronics
  },
  {
    name: "Mechanical Keyboard",
    description: "Mechanical keyboard for work and gaming",
    price: 2499.00,
    stock: 15,
    category: electronics
  },
  {
    name: "Cotton T-Shirt",
    description: "Comfortable everyday cotton T-shirt",
    price: 499.00,
    stock: 40,
    category: fashion
  },
  {
    name: "Ruby on Rails Guide",
    description: "A guide to learning web application development",
    price: 799.00,
    stock: 12,
    category: books
  }
].each do |attributes|
  product = Product.find_or_initialize_by(name: attributes[:name])
  product.assign_attributes(attributes)
  product.save!
end

puts "Seed completed: #{Category.count} categories, #{Product.count} products"
