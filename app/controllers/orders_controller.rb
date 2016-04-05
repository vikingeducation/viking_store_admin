class OrdersController < ApplicationController

  layout 'admin_portal'

  def index
    @column_headers = ["ID", "UserID", "Address", "City", "State", "Total Value", "Status", "Date Placed", "SHOW", "EDIT", "DELETE"]
    if params[:user_id]
      unless Order.where(:user_id => params[:user_id]).size == 0
        @orders = Order.where(:user_id => params[:user_id])
        @orders_index_header = "#{User.find(params[:user_id]).full_name}'s Orders"
      else
        flash[:notice] = "Sorry, that user isn't in our system :("
        @orders = Order.all
        @orders_index_header = "Orders"
      end
    else
      @orders = Order.all
      @orders_index_header = "Orders"
    end
  end

  def new
    @order = Order.new
    @user = User.find(params[:user_id])
  end

  def show
    @column_headers = ["ProductID", "Product", "Quantity", "Price", "Total Price"]
    @order = Order.find(params[:id])
    @order_contents = @order.order_contents
  end

end
