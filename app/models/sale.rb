class Sale < ActiveRecord::Base
  has_many :quotes

  :total
  :tax
  :labor
  :parts_cost
  :date_sold
end
