ActiveAdmin.register Transfer do

  permit_params :recibido, :enviado

  show do |transfer|

    panel 'Detalles del Cliente' do
      attributes_table_for transfer, :name, :email, :phone, :address, :city, :Nit, :Notas
    end

    panel 'Creado' do
      "#{time_ago_in_words transfer.created_at} ago"
    end

     panel 'Transferencia recibida' do
      transfer.recibido
    end

    panel 'Detalles de la Transferencia' do
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
      end
    end

    panel 'Transfer Total' do
      number_to_currency_bo transfer.total_price
    end

  end

end

