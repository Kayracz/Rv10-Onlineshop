class PagesController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:index, :show, :about, :contraentrega, :termsandconditions, :envios, :pagos, :devoluciones, :instarv10]

  def index
    @products = Product.all
  end

  def about
  end

  def termsandconditions
  end

  def envios
  end

  def pagos
  end

  def devoluciones
  end

  def instarv10
  end

end


