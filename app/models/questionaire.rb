class Questionaire < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_one :quote

  :user_id
  :quote_id
  :product_type
  :comments
end
