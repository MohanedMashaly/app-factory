require 'digest'

class Api::V1::AppController < ApplicationController
  def index
    apps = Application.all
    message = "app are returned successfully"
    for app in apps
      app.token =''
    end
    return render json: {"message": message, "data":apps ,"code": status}, status: 200
  end

  def show
    @application = Application.lock.find_by(token: params[:id])
      if @application
        @application.token = ''
        return render json: {"message": "app is returned successfully", "data":@application ,"code": status}, status: 200
      else
        status = 400
        return render json: {"message": "app is not returned", "data":@application ,"code": status}, status: 400
      end
  end

  def create
    String name = params[:name]
    if validateName(name)
      application= Application.lock.new(
        name: name,
        chats_count: 0,
        token: hash_token(name)
      )
      if application.save
        return render json: {"message": "app is created successfully", "data":application ,"code": status}, status: 201
      end
    end
    status = 400
    return render json: {"message": "app is not created", "data":application ,"code": status}, status: 400
  end

  private def validateName(name)
    String regularExpression= "^[A-Za-z][A-Za-z0-9_]{1,29}$";
    if name.empty?
      return false
    end
    if !name.match(regularExpression)
      return false
    end
    if Application.find_by(token: hash_token(name))
      return false
    end
    return true
  end

  private def hash_token(name)
    return Digest::SHA256.hexdigest(name)
  end

end