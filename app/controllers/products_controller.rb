class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index, :show, :about, :women, :kids, :men, :new]
  before_action :set_product, only: [:show, :edit, :update, :destroy]


  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    @category_id = params[:category_id]
    # Creates entries in the stock table to handle the new product.
    # (This could be a create callback on the model, too.)
    Size.all.each do |s|
      Stock.create! product_id: @product.id, size_id: s.id, units: 1
    end
    redirect_to products_path
  end

   def edit
  end


  def show
    @product = Product.find(params[:id])
    @photos = Photo.all
  end

  def update
    @product.update(product_params)
    redirect_to products_path
  end

    def index
    if params.has_key?(:category)
     @category = Category.find_by_name(params[:category])
     @products = Product.where(category: @category)
    else
    @products = Product.search(params[:search])
    end
  end

  def women
    if params.has_key?(:category)
     @category = Category.find_by_name(params[:category])
    @women_product_items = Product.where(category: @category)
  else
    @women_product_items = Product.women.search(params[:search])
   end
  end

  def men
    if params.has_key?(:category)
     @category = Category.find_by_name(params[:category])
     @men_product_items = Product.where(category: @category)
   else
    @men_product_items = Product.men.search(params[:search])
  end
 end

  def kids
    if params.has_key?(:category)
     @category = Category.find_by_name(params[:category])
     @kids_product_items = Product.where(category: @category)
   else
    @kids_product_items = Product.kids
  end
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
      params.require(:product).permit(:title, :photo, :color, :description, :price, :category_id, :category, :subcategory, :promo, :codigo)
    end
end
