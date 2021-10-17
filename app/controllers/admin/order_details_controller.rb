class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order

    # order_status　2→制作中　3→発送準備中

    case @order_detail.make_status_i18n
      when "制作中"
        @order.update(order_status: 2)
      when "制作完了"
        if @order.order_details.all?{ |order_detail| order_detail.make_status_i18n == "制作完了" }
           @order.update(order_status: 3)
        end
    end


    # if @order_detail.make_status_i18n == "制作中"
    #   @order_detail.order.order_status_i18n = "制作中"
    #   @order_detail.order.save
    # elsif @order_detail.make_status_i18n == "制作完了"
    #       @order_detail.order.order_status_i18n = "発送準備中"
    #       @order_detail.order.save
    # end

    redirect_to admin_order_path(@order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:make_status)
  end
end
