class DashboardController < ApplicationController
  include DashboardHelper
  def index
    @users_seven_days = total_users(7)
    @orders_seven_days = total_orders(7)
    @products_seven_days = total_new_products(7)
    @revenue_seven_days = total_revenue(7)

    @users_thirty_days = total_users(30)
    @orders_thirty_days = total_orders(30)
    @products_thirty_days = total_new_products(30)
    @revenue_thirty_days = total_revenue(30)

    #update if database exists in 100 years
    @users_all_time = total_users(36000)
    @orders_all_time = total_orders(36000)
    @products_all_time = total_new_products(36000)
    @revenue_all_time = total_revenue(36000)

    @top_states = top_three_states

    @top_cities = top_three_cities
  end


end
