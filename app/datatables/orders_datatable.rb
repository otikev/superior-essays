class OrdersDatatable < ApplicationDatatable

private

	def data
		orders.map do |order|
			[].tap do |column|
				column << order.code
				column << order.order_status.name
				column << order.order_type.name
				column << order.topic
				if order.paid?
					column << '<span class="badge bg-success badge-pill">Paid</span>'
				else
					column << '<span class="badge bg-warning badge-pill">Pending</span>'
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

		_user_id = @view.instance_variable_get(:@current_user).id
		_order_status_id = @view.instance_variable_get(:@order_status).id

		orders = Order.where(user_id: _user_id, order_status_id: _order_status_id).order("#{sort_column} #{sort_direction}").page(page).per_page(per_page)

		if params[:search].present?
			orders = orders.joins([:user, :order_status, :order_type]).where(search_string.join(' or '), search: "%#{params[:search][:value].downcase}%")
		end
		orders
	end

	def columns
		%w(order_statuses.name order_types.name topic code)
	end
end
