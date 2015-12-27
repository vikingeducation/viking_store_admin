class DashboardController < ApplicationController
  def index
    # Panel 1: Overall Platform
    @overall_7_days = get_overall_stats(7)
    @overall_30_days = get_overall_stats(730)
    @overall_total = get_overall_stats

    # Panel 2: User Demographics and Behavior
    @top_states = State.top_3_by_users
    @top_cities = City.top_3_by_users
    @behavior_stats = [
      {criteria: 'Highest Single Order Value',
        result: get_highest_order_user,
        currency: true},
      {criteria: 'Highest Lifetime Value',
        result: get_highest_aggregation_user('SUM'),
        currency: true},
      {criteria: 'Highest Average Order Value',
        result: get_highest_aggregation_user('AVG'),
        currency: true},
      {criteria: 'Most Orders Placed',
        result: get_highest_aggregation_user('COUNT'),
        currency: false}
    ]

    # Panel 3: Order Statistics
    @order_stats_7_days = Order.get_order_stats(7)
    @order_stats_30_days = Order.get_order_stats(30)
    @order_stats_total = Order.get_order_stats

    # Panel 4: Time Series Data
    @orders_by_day = Order.get_orders_by_time('day')
    @orders_by_week = Order.get_orders_by_time('week')
  end

  private

  def get_overall_stats(days_ago = nil)
    if days_ago
      {
        num_users: User.days_ago(days_ago).count,
        num_orders: Order.days_ago(days_ago).completed.count,
        num_products: Product.days_ago(days_ago).count,
        total_revenue: Order.get_revenue(days_ago)
      }
    else
      {
        num_users: User.all.count,
        num_orders: Order.completed.count,
        num_products: Product.all.count,
        total_revenue: Order.get_revenue
      }
    end
  end

  # Join clause to join users with order_totals table
  def user_order_totals_join(days_ago = nil)
    "JOIN (#{Order.order_totals_query(days_ago)}) ot ON ot.user_id = users.id"
  end

  # Returns first_name, last_name, revenue for each order
  def user_order_totals(days_ago = nil)
    User.select("users.first_name, users.last_name, ot.revenue as amount").joins(user_order_totals_join)
  end

  def get_highest_order_user
    user_order_totals.order("amount DESC").limit(1)[0]
  end

  def get_highest_aggregation_user(aggregator)
    User.select("users.first_name, users.last_name, #{aggregator}(ot.revenue) as amount").joins(user_order_totals_join).group("users.id").order("amount DESC").limit(1)[0]
  end

end
