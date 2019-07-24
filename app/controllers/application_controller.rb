class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :sizes

  private
  # Returns a collection of key/value pairs that we
  # can use as options for select on combos that 
  # shows sizes.
  # [["XS", 1],["S", 2],["M", 3]...]
  def sizes
    Size.all.collect {|s| [s.name, s.id] }
  end
end
