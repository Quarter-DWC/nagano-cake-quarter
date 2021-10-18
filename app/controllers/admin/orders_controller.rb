class Admin::OrdersController < ApplicationController
  # before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  # confirm_payment == 入金確認　make_status:1 == 制作待ち
  def update
    order = Order.find(params[:id])
    order_details = order.order_details
    if order.update(order_params)
      if order.order_status == "confirm_payment"
         order_details.each { |order_detail|
         order_detail.update(make_status:1)
         }
      # elsif order.order_status == "not_payment"
      #       order_details.each { |order_detail|
      #       order_detail.update(make_status:0)
      #   }
      end

      redirect_to admin_order_path(order)
    else
      redirect_to request.referer
    end



  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end


end
