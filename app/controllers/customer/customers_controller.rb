class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
  end

  def edit
  end

  def update
    if current_customer.update(customer_params)
      redirect_to mypage_customers_path, notice: "顧客情報を更新しました。"
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name,
      :first_name,
      :kana_last_name,
      :kana_first_name,
      :email,
      :postal_code,
      :address,
      :phone_number,
      )
  end

end
