module CurrentCart

  private
  def current_cart
    @cart ||= Cart.find_by_id(session[:cart_id])
  end

  def set_cart
    # find_by_id to avoid exceptions.
    @cart = Cart.find_by_id(session[:cart_id])
    @cart = Cart.create unless @cart
    session[:cart_id] = @cart.id
  end

  # def set_cart
  #   @cart = Cart.find(session[:cart_id])
  #   rescue ActiveRecord::RecordNotFound
  #   @cart = Cart.create
  #   session[:cart_id] = @cart.id
  # end

end
