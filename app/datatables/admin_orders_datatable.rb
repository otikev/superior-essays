class AdminOrdersDatatable < ApplicationDatatable

private

	def data
		orders.map do |order|
			[].tap do |column|
				column << order.user.email
				column << order.code
				column << order.order_status.name
				column << order.order_type.name
				column << order.topic
				if order.paid?
					column << "Paid"
				else
					column << "Pending"
				end
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
		Order.count
	end

	def total_entries
		orders.total_entries
	end

	def orders
		@orders ||= fetch_orders
	end

	def fetch_orders
		search_string = []
		columns.each do |term|
			search_string << "lower(#{term}) like :search"
		end

		orders = Order.order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)
		if params[:search].present?
			orders = orders.joins([:user, :order_status, :order_type]).where(search_string.join(' or '), search: "%#{params[:search][:value].downcase}%")
		end
		orders
	end

	def columns
		%w(order_statuses.name order_types.name topic users.email code)
	end

end
