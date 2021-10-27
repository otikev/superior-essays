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
					column << '<span class="badge bg-success badge-pill">Paid</span>'
				else
					column << '<span class="badge bg-danger badge-pill">Pending</span>'
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
		raw_fetch.count
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

		orders = raw_fetch.page(page).per_page(per_page)
		if params[:search].present?
			orders = orders.joins([:user, :order_status, :order_type]).where(search_string.join(' or '), search: "%#{params[:search][:value].downcase}%")
		end
		orders
	end

	def columns
		%w(order_statuses.name order_types.name topic users.email code)
	end

	def raw_fetch
		_order_status_id = @view.instance_variable_get(:@order_status).id
		Order.where(order_status_id: _order_status_id).order(id: :desc)
	end
end
