class AddReferenceRequesterTypeIdToQuote < ActiveRecord::Migration
  def change
    add_reference :quotes, :requester_type, index: true, foreign_key: true
  end
end
