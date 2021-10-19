class Customer::CartProductsController < ApplicationController
  before_action :authenticate_customer!
  before_action :setup_cart_product!, except: [:index, :destroy_all]
  before_action :setup_cart_products!

  def index
  end

  def create
    if @cart.blank?
      @cart = current_customer.cart_products.new(cart_product_params)
    else
      @cart.quantity += params[:cart_product][:quantity].to_i
    end
    if @cart.save
      redirect_to cart_products_path
    else
      redirect_to products_path
    end
  end

  def update
    if @cart.update(cart_product_params)
      redirect_to cart_products_path
    else
      render 'index'
    end
  end

  def destroy
    @cart.destroy
    redirect_to cart_products_path
  end

  def destroy_all
    @carts.destroy_all
    redirect_to cart_products_path
  end

  private

  # 商品IDに該当するカート内商品を取得
  def setup_cart_product!
    @cart = current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id])
  end

  # ログイン中のカスタマーのカート内商品を全て取得
  def setup_cart_products!
    @carts = current_customer.cart_products.includes(:product)
  end

  def cart_product_params
    params.require(:cart_product).permit(:product_id, :quantity)
  end

end