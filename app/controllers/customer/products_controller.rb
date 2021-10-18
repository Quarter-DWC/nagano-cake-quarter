class Customer::ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(8).reverse_order
    @genres = Genre.includes(:products)
    @total_products = Product.all.count
  end
  def show
    @product = Product.find(params[:id])
    @genres = Genre.includes(:products)
    @cart = CartProduct.new
  end
end
