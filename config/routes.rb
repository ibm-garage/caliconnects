Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root "hello_world#index"

  get "/hello_world" => "hello_world#index"
  get "/maps" => "maps#index"

  namespace :admin do
    resources :campaigns, only: [:index, :create, :show, :destroy] do
      resources :alerts, only: [:new, :create]
    end
  end
end

