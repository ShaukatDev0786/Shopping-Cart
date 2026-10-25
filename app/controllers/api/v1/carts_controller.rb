# class Api::V1::CartsController < ApplicationController
# end  both are correct
module Api
  module V1
    class CartsController < ApplicationController
      # Create a new shopping cart for a guest customer.
      # SecureRandom.uuid? -> It generates a unique identifier for the guest cart, so the customer can continue using the same cart without logging in.
      def create
        cart = Cart.create!(token: SecureRandom.uuid)

        render json: {
          token: cart.token,
          message: "Cart created successfully"
        }, status: :created
      end

      # Retrieve a cart and its items using the guest cart token.
      def show
        # Find the cart using the token supplied in the URL.
        cart = Cart.find_by(token: params[:token])

        # Return a 404 response if the cart does not exist.
        unless cart
          render json: { error: "Cart not found" }, status: :not_found
          return
        end

        # Load associated products efficiently to avoid repeated database queries.
        items = cart.cart_items.includes(:product)

        # Start with decimal zero so an empty cart also has a valid decimal subtotal.
        subtotal = items.sum(BigDecimal("0")) do |item|
          item.unit_price * item.quantity
        end

        # Return the cart details, its items, and the subtotal as JSON.
        render json: {
          token: cart.token,
          items: items.map do |item|
            {
              id: item.id,
              product_id: item.product_id,
              product_name: item.product.name,
              quantity: item.quantity,
              unit_price: item.unit_price.to_s("F"),
              line_total: (item.unit_price * item.quantity).to_s("F")
            }
          end,
          subtotal: subtotal.to_s("F")
        }, status: :ok
      end
    end
  end
end
