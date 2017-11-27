class Product < ActiveRecord::Base
  belongs_to :quote
  has_many :product_details
end
