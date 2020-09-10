Rails.application.routes.draw do
  devise_for :users

  resources :galleries do
    resources :memories
  end

  root "memories#welcome"
  get "/:page" => "static#show"
end
