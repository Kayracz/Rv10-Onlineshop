class PhotosController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index, :show, :about]
  before_action :set_product, only: [:new, :show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!
  # GET /albums
  # GET /albums.json
  def index
    @photos = Photo.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @photos = Photo.all
    # @photo = Photo.find(params[:id])
    # @photos = Photo.all
    # @photo = Album.find(params[:album_id])

  end

  # GET /albums/new
  def new
    @photo = Photo.new
    @product = Product.find(params[:product_id])

  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @photo = Photo.new(photo_params)
    @photo.save
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update

  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @photo = Photo.find(params[:id])
    end

      def photo_params
      params.require(:photo).permit(:photo, :photos_attributes => [:product_id, :photo])
      # params.require(:album).permit(:title, :description, :photo)
    end
end
