Rails.application.routes.draw do
  namespace :api do
    resources :posts, only: %i(index show create update destroy)
  end
end
