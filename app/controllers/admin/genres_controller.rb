class Admin::GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update]

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).per(10)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "You have created genre successfully."
    else
      @genres = Genre.page(params[:page]).per(10)
      render 'index'
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "You have updated genre successfully."
    else
      render "edit"
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end
end
