class CreateQuestionaires < ActiveRecord::Migration
  def change
    create_table :questionaires do |t|
      t.references :users, index: true, foreign_key: true
      t.references :quote, index: true, foreign_key: true
      t.string :product_type
      t.text :comments

      t.timestamps null: false
    end
  end
end
