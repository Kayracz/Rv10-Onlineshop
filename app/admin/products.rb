ActiveAdmin.register Product do
permit_params :title, :description,:subcategory, :price, :size, :size2, :photo, :category, :color, :codigo
end
