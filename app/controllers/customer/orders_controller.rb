class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
    @order = Order.new
    @deliveries = current_customer.deliveries

  end

  def confirm
    @order = Order.new(order_params)
    @cart_products = current_customer.cart_products
    @order.payment_method = params[:order][:payment_method]

    # 住所選択のラジオボタンで条件分岐。0==自分の住所,1==登録済み住所,2==新しい住所
    case params[:order][:to_address]
      when "0" then
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.address_name = current_customer.full_name
      when "1" then
        @my_delivery = current_customer.deliveries.find(params[:order][:my_deliveries])
        @order.postal_code = @my_delivery.postal_code
        @order.address = @my_delivery.address
        @order.address_name = @my_delivery.address_name
      when "2" then
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.address_name = params[:order][:address_name]
    end

  end

  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
  end

  def index
    # ページネーションは入れるべき？
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def thanks
  end

  private

  # feeとorder_statusはデフォルトがあるので除外
  def order_params
    params.require(:order).permit(
      :payment_method,
      :total_price,
      :postal_code,
      :address,
      :address_name
      )
  end

end