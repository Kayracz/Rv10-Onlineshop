class CategoriesController < InheritedResources::Base
 include CurrentCart
  before_action :set_cart, only: [:new, :create, :show, :index, :edit]
  before_action :set_category, only: [:show, :edit, :destroy]


 def index
  @categories = Category.all
 end

 def show
    @categories = Category.all
  end


  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description, :display_in_men, :display_in_women, :categories_attributes => [:product_id, :category])
    end
end
