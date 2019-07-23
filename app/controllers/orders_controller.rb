class OrdersController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :destroy, :contraentrega]


def index
  @orders = Order.all
end

def new
  if @cart.product_items.empty?
    redirect_to product_url, notice: 'Your Cart is Empty'
    return
  end
  @order = Order.new
  @client_token = Braintree::ClientToken.generate

end

  def create
    @order = Order.new(order_params)
    if @order.save
      charge
      if @result.success?
        @order.add_product_items_from_cart(@cart)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifierMailer.recieved(@order).deliver
        redirect_to root_url, notice: 'Thank You for Your Order!'
      else
        flash[:error] = 'Check Your Cart'
        redirect_to root_url, alert: @result.message
        @order.destroy
      end
    else
      @client_token = Braintree::ClientToken.generate
      render :new
    end
  end

  def contraentrega
    @order = Order.new(order_params)
    if @order.save
        @order.add_product_items_from_cart(@cart)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifierMailer.recieved(@order).deliver
        redirect_to root_url, notice: 'Gracias por su pedido!'
      else
        flash[:error] = 'Check Your Cart'
        redirect_to root_url, alert: @result.message
        @order.destroy
      end
    else
      render :new
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
    params.require(:order).permit(:name, :email, :address, :city, :country, :Nit, :Notas, :phone)
  end

  def charge
    @result = Braintree::Transaction.sale(
      amount: @cart.total_price,
      payment_method_nonce: 'fake-valid-nonce')
  end


end

