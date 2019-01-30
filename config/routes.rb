Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        get '/searches', to: 'searches#index'
      end
    end
end
