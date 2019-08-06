class Product < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  before_destroy :ensure_not_product_item

  has_many :product_items
  has_many :categories

  has_many :photos, :inverse_of => :product, :dependent => :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, :description, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true

  def total_price
   product.price * quantity
  end

  def ensure_not_product_item
    if product_items.empty?
      return true
    else
      errors.add(:base, 'You have Product Items')
      return false
    end
  end

 def self.women
   where(subcategory: 'women')
 end

 def self.men
   where(subcategory: 'men')
 end

  def self.kids
   where(subcategory: 'kids')
 end

 def sale_price
  price * promo.to_i * 10 / 100
end

end

