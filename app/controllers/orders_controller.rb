class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create, :show, :orderdashboard]
  before_action :set_order, only: [:show, :edit, :destroy]

  def index
    @orders = Order.all
  end

  def new
    if @cart.product_items.empty?
      redirect_to product_url, notice: 'Tu carrito esta vacio'
      return
    end
    @order = Order.new
    # @client_token = Braintree::ClientToken.generate
  end

  def create
    @order = Order.new(order_params)
    @order.add_product_items_from_cart(@cart)
    if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        redirect_to @order, notice: 'Gracias por su pedido!'
    else
      render :new, notice: 'Porfavor chequea tu informacion'
    end
  end


  def orderdashboard
     @orders = Order.all
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
    params.require(:order).permit(:name, :email, :phone, :address,
                                  :city, :country, :Nit, :terminos, :Notas)
  end

  # def charge
  #   @result = Braintree::Transaction.sale(
  #     amount: @cart.total_price,
  #     payment_method_nonce: 'fake-valid-nonce')
  # end
end
