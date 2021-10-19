class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
  end

  def confirm
  end

  def create
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def thanks
  end

end
