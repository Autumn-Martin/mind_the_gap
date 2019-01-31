Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        get '/searches', to: 'searches#index'

        get '/campsites/available', to: 'campsites#available'
      end
    end
end
