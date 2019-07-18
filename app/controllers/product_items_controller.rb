class ProductItemsController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:create, :edit]
  before_action :set_product_item, only: [:show, :index, :new, :destroy, :edit]

  def create
    product = Product.find(params[:product_id])
    @product_item = @cart.add_product(product.id)
    if @product_item.save
      redirect_to products_url, notice: 'Product added to Cart'
    else
    render :new
    end
  end

   def new
    @product = Product.all
    @product = Product.new
  end

  def destroy
    @product_item = ProductItem.find(params[:id])
    @product_item.destroy
    redirect_to root_url, notice: 'Order deleted'
  end

  def edit
  end

  private

  def set_product_item
    @product_item = ProductItem.find(params[:id])
  end

  def product_item_params
    params.require(:product_item).permit(:product_id, :quantity)
  end

end
