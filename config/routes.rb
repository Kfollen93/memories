Rails.application.routes.draw do
  devise_for :users
  resources :memories
  root "memories#index"
  get "/:page" => "static#show"
end
