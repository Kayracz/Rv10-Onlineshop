ActiveAdmin.register Transfer do

  show do |transfer|

    panel 'Customer Details' do
      attributes_table_for transfer, :name, :email, :phone, :address, :city, :Nit, :Notas
    end

    panel 'Created' do
      "#{time_ago_in_words transfer.created_at} ago"
    end

    panel 'Transfer Details' do
      table_for(transfer.product_items) do
        column 'Product' do |item|
          item.product.title
        end
        column 'Quantity' do |item|
          item.quantity
        end
        column 'Price' do |item|
          number_to_currency_bo item.total_price
        end
         column 'Size' do |item|
          item.size.name
        end
          column 'Codigo' do |item|
          item.product.size2
        end
      end
    end

    panel 'Transfer Total' do
      number_to_currency_bo transfer.total_price
    end

  end

end

