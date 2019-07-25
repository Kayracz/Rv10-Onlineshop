class ProductItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :edit]
  before_action :set_product_item, only: [:show, :index, :new, :destroy, :edit]

  # add item
  def create
    puts params

    product = Product.find(params[:product_id])
    size_id = params[:size_id]
    @product_item = @cart.add_product(product.id, size_id)
    if @product_item.save
      # How critical is the stock update?
      # For now, let's assume that as long as the 
      # item gets added to the cart we are good to go.
      Stock.decrease product.id, size_id, 1
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
    @product_item = ProductItem.find(params[:id])
    @product_item.quantity += 1
    @product_item.save

    # Update inventory
    Stock.decrease @product_item.product.id, @product_item.size.id, 1
    redirect_to cart_path(@current_cart)
  end

  def reduce_quantity
    @product_item = ProductItem.find(params[:id])
    if @product_item.quantity > 1
      @product_item.quantity -= 1
      @product_item.save
      # Restore inventory.
      Stock.increase @product_item.product.id, @product_item.size.id, 1
    end

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
