class Size < ApplicationRecord
  # Returns a collection of key/value pairs that we
  # can use as options for select on combos that
  # shows sizes.
  # [["XS, 1],["S - Sin Stock", 2], ["M", 3], and so on...
   def self.options_for product_id
        all.collect do |size|
            stock = Stock.by_size(product_id, size.id)
            is_disabled = stock < 1
            [display_format(size, stock), size.id, disabled: is_disabled]
        end
    end

    private
    def self.display_format size, stock
        name = '%-3.3s' % size.name

        if stock == 0
            "#{name} - Sin Stock"
        else
            name
        end
    end
end
