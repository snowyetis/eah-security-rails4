class AddProductToQuotes < ActiveRecord::Migration
  def change
    add_reference :quotes, :product, index: true
  end
end
