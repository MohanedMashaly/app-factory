class RemoveForeignKeyConstraintFromMessage < ActiveRecord::Migration[5.0]
  def change
  remove_foreign_key "messages", column: "chat_number"
  end
end
