class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @deliveries = current_customer.deliveries
  end

  def confirm
    unless params[:order].present?
      flash[:alert] = "不正なアクセスが疑われたため処理を中断いたしました。再度注文情報を入力してください。"
      redirect_back(fallback_location: root_path)
      return
    end
    @cart_products = current_customer.cart_products
    # 住所選択のラジオボタンで条件分岐
    case params[:order][:to_address]
      when "my_address" then
        @order = Order.new(
          postal_code: current_customer.postal_code,
          address: current_customer.address,
          address_name: current_customer.full_name)
      when "list_address" then
        @my_delivery = current_customer.deliveries.find(params[:order][:my_deliveries])
        @order = Order.new(
          postal_code: @my_delivery.postal_code,
          address: @my_delivery.address,
          address_name: @my_delivery.address_name)
      when "new_address" then
        unless to_address_params.blank?
          flash[:alert] = "お届け先住所が入力されていません。情報を入力してください。"
          redirect_back(fallback_location: root_path)
        end
        @order = Order.new(
          postal_code: params[:order][:postal_code],
          address: params[:order][:address],
          address_name: params[:order][:address_name])
    end
    @order.payment_method = params[:order][:payment_method]
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    # order_detailも同時に保存し、カート内商品は全削除
    @cart_products = current_customer.cart_products
    if @order.save
      @cart_products.each do |cart|
        @order_detail = OrderDetail.new(
        order_id: @order.id,
        product_id: cart.product_id,
        quantity: cart.quantity)
        @order_detail.save
      end
      @cart_products.destroy_all
      redirect_to thanks_orders_path
    else
      redirect_to new_order_path, alert: "商品を購入できませんでした。"
    end

  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(5).reverse_order
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(
      :payment_method,
      :total_price,
      :postal_code,
      :address,
      :address_name
      )
  end

  def to_address_params
    params.require(:order).permit(
      :postal_code,
      :address,
      :address_name
      )
  end

end
