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
  end

  def thanks
  end

end
