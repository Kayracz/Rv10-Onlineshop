class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index, :shop, :show, :about]
  before_action :set_product, only: [:show, :edit, :update, :destroy]


  def index
    @product = Product.all
  end

  def show
      @product = Product.find(params[:id])
      @photos = Photo.all
  end


  def new
    @product = Product.new
  end

  def edit
  end


  def create
    product = Product.find(params[:product_id])
    @product_item = @cart.add_product(product.id)
    @product = Product.new
    @product.size = products_params[:size]

    if @product_item.save
      redirect_to shop_url, notice: 'Product added to Cart'
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
      params.require(:product).permit(:title, :photo, :description, :price, :size, :size2)
    end
end
