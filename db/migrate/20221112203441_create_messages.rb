class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :number
      t.integer :chat_number
      t.string :token
      t.string :body
      t.string  :title
      add_index :Chat, [:token, :number, :chat_number], unique: true
      t.timestamps
    end
  end
end
