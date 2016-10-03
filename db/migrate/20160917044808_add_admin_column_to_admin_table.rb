class AddAdminColumnToAdminTable < ActiveRecord::Migration
  def change
    add_column :admins, :admin, :boolean, default: true
  end
end
