class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :create, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def new
    @cart = Cart.new
  end

  def show
    @carts = Cart.all
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_url, notice: 'Tu carrito esta vacio'
  end

  private
  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params[:cart]
  end

  def invalid_cart
    logger_error = 'Estas tratando de acceder a un carrito invalido'
    redirect_to product_url,  notice:'Carrito invalido'
  end

end
