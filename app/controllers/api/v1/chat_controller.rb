class Api::V1::ChatController < ApplicationController
  def index
    token = request.parameters[:app_id]
    message = "no chats with such token or number returned"
    status = 400
    if token
      application = Application.lock.find_by(token: token)
        if application
          chats = Chat.lock.where(token: token)
          for chat in chats
            chat.token = ''
          end
          message = "chats are returned successfully"
          status = 200
      end
    end
    return render json: {"message":message, "data":chats ,"code": status}, status: status
  end

  def show
    status = 404
    message = "no chat with such token or number"
    token = request.parameters[:app_id]
    number = params[:id]
    if token
      application = Application.lock.find_by(token: token)
      if application
        chats = Chat.lock.where(["number = ? AND token = ?", number, token]).limit(1)
        if chats.exists?
          chats[0].token = ''
          status = 200
          message = "chat is returned successfully"
          return render json: {"message":message, "data":chats[0] ,"code": status}, status: status
        end
      end
    end
    return render json: {"message":message, "data":chats ,"code": status}, status: status
  end

  def create
    status = 400
    token = request.parameters[:app_id]
    message = "chat is not created"
    @application = Application.lock.find_by(token: token)
    chat = nil
    if @application
        ChatWorker.perform_async(@application.chats_count + 1, @application.token)
        @application.chats_count =  @application.chats_count + 1
        if @application.save
          status = 201
          message = "chat is created successfully"
          chat = {"number" => @application.chats_count.to_s}
        end
    end
    return render json: {"message": message, "data":chat ,"code": status}, status: status
  end

  private def validate_number(number)
    String regularExpression = "^[0-9]*$"
    if number == 0
      return false
    end
    if !(number+"").match(regularExpression)
      return false
    end
    return true
  end
end
