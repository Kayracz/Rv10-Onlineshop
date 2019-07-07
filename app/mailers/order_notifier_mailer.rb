class OrderNotifierMailer < ApplicationMailer

default from: 'Rv10 Store <kayracz@gmail.com>'

  def recieved(order)
    @order = order

    mail to: order.email, subject: 'Rv10 Order'
  end

  def shipped(order)
    @order = order

   mail to: order.email, subject: 'Rv10 Shipped'
  end
end
