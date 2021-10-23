class Customer::ProductsController < ApplicationController
  def index
    @products = Product.where(sale_status: "sale").page(params[:page]).per(9).reverse_order
    @genres = Genre.includes(:products)
    @total_products = Product.all.count
  end

  def show
    @product = Product.find(params[:id])
    @genres = Genre.includes(:products)
    @cart = CartProduct.new
  end

  def search
    @method = params[:search_method]                            # 検索方法をViewからparameterで取得
    @products = Product.where(sale_status: "sale")

    if @method == 'keyword'                                     # キーワード検索
      @content = params[:content]
      @result = @products.where('name LIKE ?', '%'+@content+'%')  # Productから部分一致でキーワードに該当する商品名を持つ全レコードを取得
    elsif @method == 'genre'                                    # ジャンル検索
      @genre_id = params[:genre_id]
      @genre_name = Genre.find(@genre_id).name                  # ジャンル名取得
      @result = @products.where(genre_id: @genre_id)              # Productから該当するジャンルIDを持つ全レコードを取得
    end

    @result = @result.page(params[:page]).per(8).reverse_order
    @total_products = @result.count
    @genres = Genre.includes(:products)

  end
end
