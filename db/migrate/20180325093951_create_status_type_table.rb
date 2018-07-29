class CreateStatusTypeTable < ActiveRecord::Migration
  def change
    create_table :quote_status_types do |t|
      t.string :status_type_name
      t.string :description
      t.string :created_by
      t.string :updated_by

      t.timestamps null: false
    end
  end
end
