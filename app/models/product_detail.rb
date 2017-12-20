class ProductDetail < ActiveRecord::Base
  belongs_to :product
  # has_many :quotes, through: :product

  :model_number
  :model_description
  :product_detail_type
  :product_id

end
