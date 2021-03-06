class Customer::HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]
  def top
    @products = Product.where(sale_status: "sale").order(created_at: :desc).limit(5)
  end
  def about
  end
end