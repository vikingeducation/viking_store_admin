class Admin::DashboardController < AdminController

  layout "application"

  def index
    # Panel 1
    # Totals Table
    @total_users = User.all.count
    @total_orders = Order.where("checkout_date IS NOT NULL").count
    @total_products = Product.all.count
    @total_revenue = OrderContent.total_revenue_since_days_ago(100000).first.total

    # Last 30 Days Table
    @users_last_thirty_days = User.created_since_days_ago(30)
    @orders_last_thirty_days = Order.created_since_days_ago(30)
    @products_last_thirty_days = Product.created_since_days_ago(30)
    @total_revenue_last_thirty_days = OrderContent.total_revenue_since_days_ago(30).first.total

    # Last 7 Days Table
    @users_last_seven_days = User.created_since_days_ago(7)
    @orders_last_seven_days = Order.created_since_days_ago(7)
    @products_last_seven_days = Product.created_since_days_ago(7)
    @total_revenue_last_seven_days = OrderContent.total_revenue_since_days_ago(7).first.total

    # Panel 2
    # Top 3 States
    top_three_states = State.top_three_states
    @best_state_name = top_three_states.first.name
    @best_state_total = top_three_states.first.total
    @second_state_name = top_three_states.second.name
    @second_state_total = top_three_states.second.total
    @third_state_name = top_three_states.third.name
    @third_state_total = top_three_states.third.total

    # Top 3 Cities
    top_three_cities = City.top_three_cities
    @best_city_name = top_three_cities.first.name
    @best_city_total = top_three_cities.first.total
    @second_city_name = top_three_cities.second.name
    @second_city_total = top_three_cities.second.total
    @third_city_name = top_three_cities.third.name
    @third_city_total = top_three_cities.third.total

    # Top Users
    biggest_single_order = User.biggest_single_order
    @biggest_order_name = "#{biggest_single_order.first.first_name} #{biggest_single_order.first.last_name}"
    @biggest_order_amount = biggest_single_order.first.amount.to_s

    biggest_lifetime_spender = User.biggest_lifetime_spender
    @biggest_lifetime_spender_name = "#{biggest_lifetime_spender.first.first_name} #{biggest_lifetime_spender.first.last_name}"
    @biggest_lifetime_spender_amount = biggest_lifetime_spender.first.amount.to_s

    biggest_average_spender = User.biggest_average_spender
    @biggest_average_spender_name = "#{biggest_average_spender.first.first_name} #{biggest_average_spender.first.last_name}"
    @biggest_average_spender_amount = biggest_average_spender.first.average_order.to_s

    most_orders_placed = User.most_orders_placed
    @most_orders_placed_name = "#{most_orders_placed.first.first_name} #{most_orders_placed.first.last_name}"
    @most_orders_placed_amount = most_orders_placed.first.total_orders

    # Panel 3
    # A lot of these table results are borrowed from the instance variables above.
    @biggest_order_amount_last_thirty_days = OrderContent.biggest_order(30).first.amount
    @biggest_order_amount_last_seven_days = OrderContent.biggest_order(7).first.amount
    @average_order_last_thirty_days = OrderContent.average_order(30)
    @average_order_last_seven_days = OrderContent.average_order(7)
    @average_order_all_time = OrderContent.average_order(100000)

  end

end