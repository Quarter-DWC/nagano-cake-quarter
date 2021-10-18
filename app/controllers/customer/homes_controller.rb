class Customer::HomesController < ApplicationController
  def top
    @products = Product.order(created_at: :desc).limit(5)
    @genres = Genre.includes(:products)
  end
  def about
  end
end
