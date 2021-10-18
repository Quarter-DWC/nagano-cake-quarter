class Admin::HomesController < ApplicationController
  # before_action :authenticate_admin!

  def top
    @orders = Order.page(params[:page]).per(10).order("updated_at DESC") 
  end

end
