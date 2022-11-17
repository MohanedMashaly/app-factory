class AddForeignKeyConstraintToChat < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :chats, :applications, column: :token, primary_key: :token
  end
end
