class Customer::DeliveriesController < ApplicationController
  before_action :authenticate_customer!
  before_action :setup_delivery!, except:[:index, :create]

  def index
    @deliveries = current_customer.deliveries
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to deliveries_path
    else
      @deliveries = current_customer.deliveries
      flash[:alert] = "配送先の登録に失敗しました。"
      render 'index' 
    end
  end

  def edit
  end

  def update
    if @delivery.update(delivery_params)
      redirect_to deliveries_path
    else
      flash[:alert] = "配送先の編集に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    @delivery.destroy
    redirect_to deliveries_path
  end

  private

  def delivery_params
    params.require(:delivery).permit(
      :customer_id,
      :postal_code,
      :address,
      :address_name
      )
  end

  def setup_delivery!
    @delivery = Delivery.find(params[:id])
  end

end
