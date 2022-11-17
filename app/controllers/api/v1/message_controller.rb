class Api::V1::MessageController < ApplicationController
  def index
    status = 400
    requestMessage = "no messages with such token or chat number"
    token = request.parameters[:app_id]
    chat_number = request.parameters[:chat_id]
    application = Application.lock.find_by(token: token)
    if application
      requestMessage = "messages are returned successfully"
      messages = Message.lock.where(["token = ? AND chat_number = ?", token, chat_number])
      for message in messages 
        message.token = ''
      status = 200
      end
    end
    return render json: {"message":requestMessage, "data":messages ,"code": status}, status: status
  end

  def show
    status = 404
    token = request.parameters[:app_id]
    chat_number = request.parameters[:chat_id]
    number = request.parameters[:id]
    requestMessage = "no message with such token or chat number"
    message = Message.lock.where(["number = ? AND token = ? AND chat_number = ?", number, token, chat_number]).limit(1)
    if message[0]
      status = 200
      message[0].token = ''
      requestMessage = "message is returned successfully"
      return render json: {"message":requestMessage, "data":message ,"code": status}, status: status
    end
    return render json: {"message":requestMessage, "data":message ,"code": status}, status: status
  end

  def create
    data = nil
    token = request.parameters[:app_id]
    chat_number = params[:chat_id]
    body = params[:body]
    status = 201
    requestMessage = "message is not created"
    @chat = Chat.lock.where(["number = ? AND token = ?", chat_number, token]).limit(1)
    if @chat.exists?
      MessageWorker.perform_async(@chat[0].messages_count + 1,token, chat_number, body)
      @chat[0].messages_count =  @chat[0].messages_count + 1
        if @chat[0].save
          status = 201
          requestMessage = "message is created successfully"
          data = {"number " => @chat[0].messages_count.to_s}
        end
    end
    return render json: {"message":requestMessage, "data":data ,"code": status}, status: status
  end

end
