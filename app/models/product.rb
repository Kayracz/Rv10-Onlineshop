class Product < ApplicationRecord
  include PgSearch

  mount_uploader :photo, PhotoUploader
  before_destroy :ensure_not_product_item

  has_many :product_items
  has_many :categories

  has_many :photos, :inverse_of => :product, :dependent => :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, :description, :color, :subcategory, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true


  pg_search_scope :full_text_search,
    against: %i(title description category subcategory color),
    :using => {
      :tsearch => {
        :dictionary => "spanish",
        :prefix => true,
        :highlight => { }
      }
    }

	def stock? size
		stock = Stock.find_by("product_id = ? AND size_id = ?", self.id, size.id)
		return stock && stock.units > 0
	end

	def self.filter_by_stock(products, size_name)
		size = Size.find_by("LOWER(name) = ?", size_name.downcase)
		return products unless size

		products.select {|p| p.stock?(size) }
	end

  def self.filter(color, price_range, size_name, subcategory)
    sql_filter = prepare_sql_filter(color, price_range, subcategory)
    if sql_filter.empty?
      all
    else
      products = where(sql_filter)
			return size_name.present? ? filter_by_stock(products, size_name) : products
    end
  end

  def self.colors
    select('DISTINCT color').map(&:color).sort!
  end

  def self.subcategories
    select('DISTINCT subcategory').map(&:subcategory).sort!
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
      [[1, 100], [101, 300], [301, 500], [501, 800], [801, 1000]]
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

  def subcategory_picker
    @subcategory
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

  def self.prepare_sql_filter(color, price_range, subcategory)
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

    if subcategory.present?
      filters << "lower(subcategory) = '#{subcategory.downcase}'"
    end

    filters.join(" AND ")
  end
end

