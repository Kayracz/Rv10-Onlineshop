ActiveAdmin.register Product do
permit_params :title, :description, :price, :size, :size2, :photo, :category
end
