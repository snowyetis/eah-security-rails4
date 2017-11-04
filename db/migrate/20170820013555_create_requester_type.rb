class CreateRequesterType < ActiveRecord::Migration
  def change
    create_table :requester_types do |t|
      t.string :requester_type_name
      t.string :requester_type_code

      t.timestamps null: false
    end
  end
end
