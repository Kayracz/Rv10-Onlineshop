class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :sizes_for

  private
  def sizes_for product_id
    Size.options_for product_id
  end
end
