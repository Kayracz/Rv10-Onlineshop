# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  unless AdminUser.find_by_email 'admin@example.com'
    AdminUser.create!(email: 'admin@example.com', 
                      password: 'password', 
                      password_confirmation: 'password')
  end

  # Add some test products.
  # Only do this when there are no real products to test the website
  unless Product.count > 0
    Product.create!(
      title: "Hoodie", description: "An awesome hoodie!", price: 23.45,
      photo: "/coolcloud/hoddie",
      size: "L", size2: "XL", category: "men")

    Product.create!(
      title: "Jean", description: "Incredible pants!", price: 45.67,
      photo: "/coolcloud/jean",
      size: "L", size2: "XL", category: "men")

    Product.create!(
      title: "Shirt", description: "An awesome shirt!", price: 56.78,
      photo: "/coolcloud/shirt",
      size: "XS", size2: "S", category: "women")

    Product.create!(
      title: "Scarf", description: "Colorful scarf!", price: 67.89,
      photo: "/coolcloud/scarf",
      size: "XS", size2: "S", category: "women")
    # =====
  end
end

unless Size.count > 0
  # Add as many as you want.
  Size.create! name: "XS"
  Size.create! name: "S"
  Size.create! name: "M"
  Size.create! name: "L"
  Size.create! name: "XL"
end

# Seeds stock for every product on every size.
unless Stock.count > 0
  Product.all.each do |p|
    Size.all.each do |s|
      Stock.create! product_id: p.id, size_id: s.id, units: 1
    end
  end
end





