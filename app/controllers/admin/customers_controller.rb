class Admin::CustomersController < ApplicationController
  # before_action :authenticate_admin!
  before_action :setup_customer!, except: [:index]

  def index
    @customers = Customer.page(params[:page]).per(10).order(id: "ASC")
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name,
      :first_name,
      :kana_last_name,
      :kana_first_name,
      :email,
      :phone_number,
      :postal_code,
      :address,
      :is_valid,
      )
  end

  def setup_customer!
    @customer = Customer.find(params[:id])
  end

end