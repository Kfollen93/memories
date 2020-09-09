Rails.application.routes.draw do
  devise_for :users
  # resources :memories

  resources :galleries do
    resources :memories
  end

  root "memories#welcome"
  get "/:page" => "static#show"
end

=begin
Rails.application.routes.draw do
  devise_for :users
  resources :memories, :galleries

  root "memories#welcome"
  get "/:page" => "static#show"
end
=end
