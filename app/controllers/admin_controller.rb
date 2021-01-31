class AdminController < ApplicationController
  before_action :must_have_admin_user

  def home
  end

  def orders
    respond_to do |format|
      format.html
      format.json { render json: AdminOrdersDatatable.new(view_context) }
    end
  end
end
