class ApplicationController < ActionController::Base
  before_action :setup_genres!
  
  private
  
  def setup_genres!
    @genres = Genre.includes(:products)
  end
end
