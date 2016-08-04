Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope module: :users do
        post :auth_tokens, to: 'auth_tokens#create'
        post :registrations, to: 'registrations#create'
      end

      resources :posts
      resources :users, only: %i(index)
    end
  end
end
