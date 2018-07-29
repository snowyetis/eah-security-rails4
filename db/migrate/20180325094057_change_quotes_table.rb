class ChangeQuotesTable < ActiveRecord::Migration
  def change
    remove_column :quotes, :approved
    remove_column :quotes, :pending
    remove_column :quotes, :rejected

    add_reference :quotes, :quote_status_type, index: true, foreign_key: true

  end
end
