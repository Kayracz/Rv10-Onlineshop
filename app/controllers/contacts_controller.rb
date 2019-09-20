class ContactsController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def index
    @contact = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to root_url, notice: 'Gracias por su mensaje!'
    else
      render :new
    end
  end



  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

end
