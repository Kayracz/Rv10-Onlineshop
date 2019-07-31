class Size < ApplicationRecord
  # Returns a collection of key/value pairs that we
  # can use as options for select on combos that
  # shows sizes.
  # [["XS, 1],["S - Sin Stock", 2], ["M", 3], and so on...
  def self.options_for product_id
    all.collect {|s| [display_format(s, product_id), s.id] }
  end

  private
  def self.display_format size, product_id
    name  = '%-3.3s' % size.name
    stock = Stock.by_size(product_id, size.id)
    if stock == 0
      "#{name} - Sin Stock"
    else
      # Show units in stock. It may be useful for debugging.
      #"#{name} - Stock #{'%3.3s' % stock}"
      "#{name}"
    end
  end
end
