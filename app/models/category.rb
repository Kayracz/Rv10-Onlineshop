class Category < ApplicationRecord
has_many :product_items, :products
end
