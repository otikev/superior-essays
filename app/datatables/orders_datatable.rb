class OrdersDatatable < ApplicationDatatable

private

	def data
		orders.map do |order|
			[].tap do |column|
				column << order.order_status.name
				column << order.order_type.name
				column << order.topic
				column << "<a href=\"/orders/show?key=#{order.key}\">
                      <i class=\"icon-eye\"></i>
                      <span>
                        View
                      </span>
                  </a>"
			end
		end
	end

	def count
		Order.where(user_id: @user.id).count
	end

	def total_entries
		orders.total_entries
	end

	def orders
		fetch_orders
	end

	def fetch_orders
		search_string = []
		columns.each do |term|
			search_string << "lower(#{term}) like :search"
		end

		orders = Order.where(user_id: @user.id).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
		if params[:search].present?
			orders = orders.joins([:user, :order_status, :order_type]).where(search_string.join(' or '), search: "%#{params[:search][:value].downcase}%")
		end
		orders
	end

	def columns
		%w(order_statuses.name order_types.name topic)
	end

end
