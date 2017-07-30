class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.string :model_number
      t.string :model_description
      t.string :product_detail_type

      t.timestamps null: false
    end
  end
end
