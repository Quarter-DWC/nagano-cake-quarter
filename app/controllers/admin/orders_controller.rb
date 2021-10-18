class Admin::OrdersController < ApplicationController
  # before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
  end

  def update

  end

  def t

  end


end
