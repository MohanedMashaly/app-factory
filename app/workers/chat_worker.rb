class ChatWorker
  include Sidekiq::Worker

  def self.perform_async(number, token)
    puts "Creating new chat"
    chat = Chat.new(
        number: number,
        messages_count: 0,
        token: token
      )
    chat.save
    puts "Chat is created successfully"
  end
end
