class AddUniqeConstraintToMessages < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, [:token, :chat_number, :number], unique: true
  end
end
