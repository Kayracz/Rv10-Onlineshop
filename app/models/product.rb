class Product < ApplicationRecord
  include PgSearch

  mount_uploader :photo, PhotoUploader
  before_destroy :ensure_not_product_item

  has_many :product_items
  has_many :categories

  has_many :photos, :inverse_of => :product, :dependent => :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true


  pg_search_scope :full_text_search, 
    against: %i(title description size category subcategory color),
    :using => {
      :tsearch => {
        :dictionary => "spanish",
        :prefix => true,
        :highlight => { }
      }
    }

  def self.filter(color, price_range, size)
    sql_filter = prepare_sql_filter(color, price_range, size)
    if sql_filter.empty?
      all
    else
      where(sql_filter)
    end
  end

  def self.color
    select('DISTINCT color').map(&:color).sort!
  end

  def self.price_range
    @@price_range_options ||= 
      price_ranges.collect {|range| ["#{range.first} - #{range.last}", range] }
  end

  def self.size
    @@size_options ||= Size.all.order(:id).collect {|size| [size.name, size.id]}
  end

  def self.price_ranges
    # TODO: Use sensible values.
    @@price_ranges ||= 
      [[1, 500], [501, 1000], [1001, 2000], [2001, 5000], [5000, 10000]]
  end


  def self.search(search)
    if search
      where(["codigo LIKE ?","%#{search}%"])
    else
      all
    end
  end

	def color_picker
		@color
	end

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

  private

  def self.prepare_sql_filter(color, price_range, size)
    # Colors
    # Price range
    # Sizes (products that are available in stock in a precise size)
    filters = []
    if color.present?
      filters << "lower(color) = '#{color.downcase}'"
    end
    
    if price_range.present?
      filters << "price BETWEEN #{price_range.first} AND #{price_range.last}"
    end

    if size.present?
      filters << "lower(size) = '#{size.downcase}'"
    end

    filters.join(" AND ")
  end
end

