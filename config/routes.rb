# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :app , only: [:index, :show, :create] do
        resources :chat , only: [:index, :show, :create] do
          resources :message , only: [:index, :show, :create] do
          end
        end
      end
    end
  end

  # namespace :api do
  #   namespace :v1 do
  #     resources :app, only: [:index, :create, :show] do
  #       resources :chat, only:[:index, :create, :show]
  #     end
  #   end
  # end

  # namespace :api do
  #   namespace :v1 do
  #     resources :app, only: [:index] do
  #       resources :chat, only:[:index] do
  #         resources :message, only:[:index, :create, :show]
  #       end
  #     end
  #   end
  # end
  
end
