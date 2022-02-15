class CreateUsersSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :users_sessions do |t|
      t.uuid :uuid, null: false
      t.integer :user_id, index: true
      t.timestamps
    end
    add_index :users_sessions, :uuid, unique: true
  end
end
