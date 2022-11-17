class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.integer :number
      t.string :token
      t.integer :messages_count
      # add_index :chat, [:token, :number], unique: true
      t.timestamps
    end
  end
end
