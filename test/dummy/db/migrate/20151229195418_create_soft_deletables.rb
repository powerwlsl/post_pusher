class CreateSoftDeletables < ActiveRecord::Migration[4.2]
  def change
    create_table :soft_deletables do |t|
      t.boolean :user_deleted
      t.timestamps null: false
    end
  end
end
