class Api::V1::ProductsController < ApplicationController
	def index
    products = Product.active.includes(:category)

    render json: products.as_json(
      only: %i[id name description price stock active category_id],
      include: {
        category: {
          only: %i[id name]
        }
      }
    )
  end

  def show
    product = Product.active.includes(:category).find(params[:id])

    render json: product.as_json(
      only: %i[id name description price stock active category_id],
      include: {
        category: {
          only: %i[id name]
        }
      }
    )
  end
end
