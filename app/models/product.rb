class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_contents
  has_many :orders, through: :order_contents

  validates :name, :price, :category_id, presence: true
  validates :price, numericality: {less_than_or_equal_to: 10000, greater_than: 0}

  scope :days_ago, -> (days_past = 7) { where("created_at > ?", days_past.days.ago) }
  scope :day_range, -> (start_day, end_day) {where("created_at >= ? AND created_at <= ?", start_day.days.ago, end_day.days.ago)}

  def times_ordered
    Order.select("DISTINCT orders.id").joins("JOIN order_contents oc ON oc.order_id = orders.id JOIN products p ON oc.product_id = p.id").where("p.id = ? AND orders.checkout_date IS NOT NULL", id).count
  end

  def carts_in
    Order.select("DISTINCT orders.id").joins("JOIN order_contents oc ON oc.order_id = orders.id JOIN products p ON oc.product_id = p.id").where("p.id = ? AND orders.checkout_date IS NULL", id).count
  end
end
