class Api::V1::CartItemsController < ApplicationController
  # Add a product to a guest cart or increase its existing quantity.
  def create
    cart = Cart.find_by(token: params[:cart_token])

    # Return 404 if the requested cart does not exist.
    unless cart
      render json: { error: "Cart not found" }, status: :not_found
      return
    end

    product = Product.find_by(id: params[:product_id])

    # Return 404 if the requested product does not exist.
    unless product
      render json: { error: "Product not found" }, status: :not_found
      return
    end

    quantity = Integer(params[:quantity], exception: false)

    # Require a positive whole-number quantity.
    unless quantity && quantity.positive?
      render json: { error: "Quantity must be a positive integer" },
             status: :unprocessable_entity
      return
    end

    # Do not allow customers to add more units than are in stock.
    existing_item = cart.cart_items.find_by(product_id: product.id)
    requested_quantity = quantity + (existing_item&.quantity || 0)

    if requested_quantity > product.stock
      render json: { error: "Requested quantity exceeds available stock" },
             status: :unprocessable_entity
      return
    end

    # Update the existing row or create a new one using the current product price.
    item = existing_item || cart.cart_items.new(product: product, unit_price: product.price)
    item.quantity = requested_quantity

    if item.save
      render json: {
        message: "Product added to cart successfully",
        item: {
          id: item.id,
          product_id: item.product_id,
          product_name: product.name,
          quantity: item.quantity,
          unit_price: item.unit_price.to_s("F"),
          line_total: (item.unit_price * item.quantity).to_s("F")
        }
      }, status: :created
    else
      render json: { errors: item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # Update the quantity of an existing item in a guest cart.
  def update
    # Find the cart using the token provided in the URL.
    cart = Cart.find_by(token: params[:cart_token])

    # Return 404 if the requested cart does not exist.
    unless cart
      render json: { error: "Cart not found" }, status: :not_found
      return
    end

    # Only allow updates to items that belong to this specific cart.
    item = cart.cart_items.includes(:product).find_by(id: params[:id])

    # Return 404 if the item is not part of this cart.
    unless item
      render json: { error: "Cart item not found" }, status: :not_found
      return
    end

    # Convert the submitted quantity to an integer and reject invalid values.
    quantity = Integer(params[:quantity], exception: false)

    unless quantity && quantity.positive?
      render json: { error: "Quantity must be a positive integer" },
             status: :unprocessable_entity
      return
    end

    # Ensure the requested quantity does not exceed the product's available stock.
    if quantity > item.product.stock
      render json: { error: "Requested quantity exceeds available stock" },
             status: :unprocessable_entity
      return
    end

    # Update the existing item rather than creating a duplicate row.
    if item.update(quantity: quantity)
      render json: {
        message: "Cart item quantity updated successfully",
        item: {
          id: item.id,
          product_id: item.product_id,
          product_name: item.product.name,
          quantity: item.quantity,
          unit_price: item.unit_price.to_s("F"),
          line_total: (item.unit_price * item.quantity).to_s("F")
        }
      }, status: :ok
    else
      render json: { errors: item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # Remove a product from a specific guest cart.
  def destroy
    # Find the cart using the token supplied in the URL.
    cart = Cart.find_by(token: params[:cart_token])

    # Return 404 if the cart does not exist.
    unless cart
      render json: { error: "Cart not found" }, status: :not_found
      return
    end

    # Find the item only within this cart to prevent cross-cart deletion.
    item = cart.cart_items.find_by(id: params[:id])

    # Return 404 if the item does not belong to this cart or does not exist.
    unless item
      render json: { error: "Cart item not found" }, status: :not_found
      return
    end

    # Delete the selected item while keeping the cart and other items intact.
    item.destroy!

    render json: {
      message: "Cart item removed successfully"
    }, status: :ok
  end
end
