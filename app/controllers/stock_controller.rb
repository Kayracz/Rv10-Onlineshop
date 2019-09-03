class StockController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index, :show, :about]
  before_action :ensure_admin

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

  def ensure_admin
    return if Rails.env.development?
    # TODO: If we are not in development monde,
    #       we have to make sure that the current user is an admin.
    #       If it's not, redirect to index or something like that.
  end
end
