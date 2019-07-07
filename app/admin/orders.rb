ActiveAdmin.register Order do

permit_params :shipped

  after_update do |order|
    OrderNotifierMailer.shipped(@order).deliver if order.shipped
  end

  show do |order|

    panel 'Customer Details' do
      attributes_table_for order, :name, :email, :address, :city, :country
    end

    panel 'Created' do
      "#{time_ago_in_words order.created_at} ago"
    end

    panel 'Shipped' do
      order.shipped
    end

    panel 'Order Details' do
      table_for(order.product_items) do
        column 'Product' do |item|
          item.product.title
        end
        column 'Quantity' do |item|
          item.quantity
        end
        column 'Price' do |item|
          number_to_currency item.total_price
        end
      end
    end

    panel 'Order Total' do
      number_to_currency order.total_price
    end

  end

end
