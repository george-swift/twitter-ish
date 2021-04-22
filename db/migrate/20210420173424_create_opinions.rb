class CreateOpinions < ActiveRecord::Migration[6.1]
  def change
    create_table :opinions do |t|
      t.text :text
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :opinions, [:user_id, :created_at]
  end
end
