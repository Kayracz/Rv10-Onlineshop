ActiveAdmin.register Product do
  permit_params :title, :description, :size, :size2, :price, :photo
end
