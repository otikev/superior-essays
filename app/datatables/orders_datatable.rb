class OrdersDatatable < ApplicationDatatable

private

	def data
		orders.map do |order|
			[].tap do |column|
				column << order.order_type
				column << order.topic
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
			orders = orders.joins(:user).where(search_string.join(' or '), search: "%#{params[:search][:value].downcase}%")
		end
		orders
	end

	def columns
		%w(order_type topic)
	end

end
