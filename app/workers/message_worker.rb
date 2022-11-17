class MessageWorker
  include Sidekiq::Worker

  def self.perform_async(message_count, token, number, body)
    puts 'Creating new message'
    print(number)
    message = Message.new(
      number: message_count,
      token: token,
      chat_number: number,
      body:body
    )
    message.save
    puts "message is created successfully"
  end
end
