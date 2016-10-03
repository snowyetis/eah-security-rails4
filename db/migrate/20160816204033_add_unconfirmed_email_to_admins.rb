class AddUnconfirmedEmailToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :unconfirmed_email, :string
  end
end
