class RenameQuestionaireUsersIdToUserId < ActiveRecord::Migration
  def change
    rename_column :questionaires, :users_id, :user_id
  end
end
