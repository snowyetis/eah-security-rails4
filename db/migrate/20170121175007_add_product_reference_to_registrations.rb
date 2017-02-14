class AddProductReferenceToRegistrations < ActiveRecord::Migration
  def change
    add_reference :registrations, :product, index: true
  end
end
