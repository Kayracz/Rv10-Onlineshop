class OrdersController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :destroy]

  def index
    @orders = Order.all
  end

  def new
    if @cart.product_items.empty?
      redirect_to shop_url, notice: 'Your Cart is Empty'
      return
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_product_items_from_cart(@cart)
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to root_url, notice: 'Thank You for Your Order!'
    else
      render :new, notice: 'Please check your form'
    end
  end

  def show
  end

  def destroy
    @order.destroy
    redirect_to root_url, notice: 'Order deleted'
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :address, :city, :country)
  end

end

