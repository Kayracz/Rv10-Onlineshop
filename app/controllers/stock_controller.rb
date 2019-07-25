class StockController < ApplicationController
  layout false
  helper_method :units_in_stock

  def index
    @products = Product.all
  end

  def update
    Stock.adjust params[:product_id], params[:size_id], params[:units]
    redirect_to action: :index
  end

  private
  def units_in_stock product_id, size_id
    Stock.by_size product_id, size_id
  end
end
