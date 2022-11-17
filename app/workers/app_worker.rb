class AppWorker
  include Sidekiq::Worker

  def perform(name, token)
    puts "Creating new application"    
    application = Application.new(
      name: name,
      chats_count: 0,
      token: token
    )
    application.save
    puts "app is created successfully"
  end
end
