class Customer::CustomersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_customer!

  def show
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

# decviseのcurrent-userの代わり。あとで削除
  def set_customer!
    @current_user = Customer.find(1)
  end

end
