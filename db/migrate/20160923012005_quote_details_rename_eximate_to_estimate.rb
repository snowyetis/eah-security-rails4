class QuoteDetailsRenameEximateToEstimate < ActiveRecord::Migration
  def change
    rename_column :quote_details, :eximate, :estimate
  end
end
