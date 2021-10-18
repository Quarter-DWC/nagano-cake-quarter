class Customer::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  def top
    @products = Product.order(created_at: :desc).limit(5)
    @genres = Genre.includes(:products)
  end
  def about
  end
end
