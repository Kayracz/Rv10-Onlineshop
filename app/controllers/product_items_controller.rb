class ProductItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :edit]
  before_action :set_product_item, only: [:show, :index, :new, :destroy, :edit]

  # add item
  def create
    product = Product.find(params[:product_id])
    size_id = params[:size_id]
    @product_item = @cart.add_product(product.id)
    if @product_item.save && Stock.decrease product.id, size_id, 1
      redirect_to products_url, notice: 'Product added to Cart'
    else
      render :new
    end
  end

  def destroy
    @product_item = ProductItem.find(params[:id])
    @product_item.destroy
    redirect_to cart_path(@current_cart)
    # redirect_to root_url, notice: 'Order deleted'
  end

  def add_quantity
    @current_item.quantity += 1
    @product_item.save
    redirect_to cart_path(@current_cart)
  end

  def reduce_quantity
    @product_item = ProductItem.find(params[:id])
    if @product_item.quantity > 1
      @product_item.quantity -= 1
    end
    @product_item.save
    redirect_to cart_path(@current_cart)
  end

  private
  def set_product_item
    @product_item = ProductItem.find(params[:id])
  end

  def product_item_params
    params.require(:product_item).permit(:product_id, :quantity)
  end

end
