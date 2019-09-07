class PagesController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:index, :show, :about, :contraentrega, :termsandconditions]

  def index
    @products = Product.all
  end

  def about
  end

  def termsandconditions
  end

end


