ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    section 'Recent Orders' do
      table_for Order.order('created_at DESC').limit(10) do
        column :name
        column :total_price do |order|
          number_to_currency order.total_price
        end
        column :created_at do |order|
          time_ago_in_words order.created_at
        end
      end
      strong {link_to 'View All Orders', admin_orders_path}
    end
  end # content
end
