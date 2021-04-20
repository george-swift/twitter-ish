class ChangeForeignKeyForOpinions < ActiveRecord::Migration[6.1]
  def change
    rename_column :opinions, :user_id, :author_id
  end
end
