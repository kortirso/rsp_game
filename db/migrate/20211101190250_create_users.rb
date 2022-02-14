class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.uuid :uuid, null: false
      t.string :username, null: false, default: ''
      t.string :password_digest, null: false, default: ''
      t.timestamps
    end
    add_index :users, :uuid, unique: true
    add_index :users, :username, unique: true
  end
end
