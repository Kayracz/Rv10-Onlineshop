class Category < ApplicationRecord
has_many :products
has_many :product_items, dependent: :destroy
end
