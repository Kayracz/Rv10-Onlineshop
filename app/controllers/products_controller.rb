class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index, :shop, :show, :about, :women, :kids, :men, :new]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    redirect_to products_path
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @photos = Photo.all
  end

  def update
    @product.update(product_params)
    redirect_to products_path
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

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
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
