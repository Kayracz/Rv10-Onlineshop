class Product < ApplicationRecord

  validates :title, :description, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true

    mount_uploader :photo, PhotoUploader
end
