class Product < ApplicationRecord
  def self.product_created_seven_days
    Product.where('created_at > ?',(Time.now - 7.days)).count 
  end

  def self.product_created_thirty_days
    Product.where('created_at > ?',(Time.now - 30.days)).count 
  end

  def self.product_count
    Product.count 
  end
end
