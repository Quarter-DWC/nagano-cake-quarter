class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genres_and_sale_statuses!, only: [:new, :edit]
  before_action :set_product!, only: [:show, :edit, :update]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "You have created product successfully."
    else
      @products = Product.page(params[:page]).per(10)
      render 'index'
    end
  end

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "You have updated product successfully."
    else
      render "edit"
    end
  end

  def search
  end

  private

  def product_params
    params.require(:product).permit(:genre_id, :name, :introduction, :price, :image, :sale_status)
  end

  def set_genres_and_sale_statuses!
    @genres = Genre.all
    #enumの項目を保管 viewでeachするため
    @sale_statuses = Product.sale_statuses_i18n
  end

  def set_product!
    @product = Product.find(params[:id])
  end

end
