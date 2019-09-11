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
    if params.key?(:category)
     @category = Category.find_by_name(params[:category])
      @pagy,@products =  pagy(Product.where(category: @category))
    else
    @pagy, @products = pagy(Product.search(params[:search]), items:9)
    end
  end

  def women
    if params.key?(:category)
     @category = Category.find_by_name(params[:category])
     @pagy,@women_product_items = pagy(Product.where(category: @category))
  else
     @pagy,@women_product_items = pagy(Product.women.search(params[:search]))
   end
  end

  def men
    if params.key?(:category)
     @category = Category.find_by_name(params[:category])
     @pagy,@men_product_items = pagy(Product.where(category: @category))
   else
    @pagy,@men_product_items = pagy(Product.men.search(params[:search]))
  end
 end

  def kids
    if params.key?(:category)
     @category = Category.find_by_name(params[:category])
     @pagy,@kids_product_items = pagy(Product.where(category: @category))
   else
    @pagy,@kids_product_items = pagy(Product.kids.search(params[:search]))
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
