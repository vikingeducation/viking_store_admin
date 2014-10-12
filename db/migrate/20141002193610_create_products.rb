class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :title
      t.text    :description
      t.float   :price
      t.string  :sku
      


      t.timestamps
    end
  end
end