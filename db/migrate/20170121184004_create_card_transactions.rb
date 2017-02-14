class CreateCardTransactions < ActiveRecord::Migration
  def change
    create_table :card_transactions do |t|
      t.references :card, index: true, foreign_key: true
      t.string :action
      t.integer :amount
      t.boolean :success
      t.string :authorization
      t.string :message
      t.text :params

      t.timestamps null: false
    end
  end
end
