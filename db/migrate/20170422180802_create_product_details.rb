class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|

      t.timestamps null: false
    end
  end
end
