class UsersDatatable < ApplicationDatatable

private

	def data
		users.map do |user|
			[].tap do |column|
				column << user.id
				column << user.email
				column << user.first_name
				column << user.last_name
				if user.enabled?
					column << '<span class="badge bg-success badge-pill">Enabled</span>'
				else
					column << '<span class="badge bg-danger badge-pill">Disabled</span>'
				end
				column << "<a href=\"/admin/user?key=#{user.key}\">
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
		users.total_entries
	end

	def users
		@users ||= fetch_users
	end

	def fetch_users
		search_string = []
		columns.each do |term|
			search_string << "lower(#{term}) like :search"
		end

		users = raw_fetch.page(page).per_page(per_page)
		if params[:search].present?
			users = users.where(search_string.join(' or '), search: "%#{params[:search][:value].downcase}%")
		end
		users
	end

	def columns
		%w(first_name last_name email)
	end

	def raw_fetch
		_role = @view.instance_variable_get(:@role)
		User.where(admin: _role == "admin").order(id: :desc)
	end
end
