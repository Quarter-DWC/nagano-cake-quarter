class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)


    # order_status:　now_cooking→制作中　now_packing→発送準備中   make_status:   now_cooking→制作中　complete_cooking→制作完了

      case @order_detail.make_status
        when "now_cooking"
          @order.update(order_status: "now_cooking")
        when "complete_cooking"
          if @order.order_details.all?{ |order_detail| order_detail.make_status == "complete_cooking" }
             @order.update(order_status: "now_packing")
          end
      end

      redirect_to admin_order_path(@order_detail.order)
    else
      redirect_to request.referer
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:make_status)
  end
end
