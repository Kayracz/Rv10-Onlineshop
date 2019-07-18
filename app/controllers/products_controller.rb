class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index, :shop, :show, :about, :women, :kids, :men]
  before_action :set_product, only: [:show, :edit, :update, :destroy]


  def index
    @product = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @photos = Photo.all
  end


  def women
    @women_product_items = Product.women
  end

  def men
    @men_product_items = Product.men
  end

  def kids
    @kids_product_items = Product.kids
  end


  def new
    @product = Product.new
  end

  def edit

  end


  def create
    product = Product.find(params[:product_id])
    @product_item = @cart.add_product(product.id)
    @product.size = product_params[:size]
    if @product_item.save
      redirect_to product_url, notice: 'Product added to Cart'
    else
    render :new
    end
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :photo, :description, :price, :size, :size2, :category)
    end
end
