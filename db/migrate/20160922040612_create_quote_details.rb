class CreateQuoteDetails < ActiveRecord::Migration
  def change
    create_table :quote_details do |t|
      t.references :quote
      t.text :quote_comments
      t.string :approved_by
      t.string :rejected_by
      t.text :rejected_reason
      t.decimal :eximate

      t.timestamps null: false
    end
  end
end
