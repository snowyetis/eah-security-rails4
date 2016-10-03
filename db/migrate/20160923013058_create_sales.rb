class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.references :quotes, index: true, foreign_key: true
      t.decimal :total
      t.decimal :tax
      t.decimal :labor
      t.decimal :parts_cost
      t.datetime :date_sold
    end
  end
end
