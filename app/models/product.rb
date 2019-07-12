class Product < ApplicationRecord

  mount_uploader :photo, PhotoUploader
  before_destroy :ensure_not_product_item

  has_many :product_items

  has_many :photos, :inverse_of => :product, :dependent => :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, :size, :description, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true


  def ensure_not_product_item
    if product_items.empty?
      return true
    else
      errors.add(:base, 'You have Product Items')
      return false
    end
  end


end

