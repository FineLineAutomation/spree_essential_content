#Rails.application
Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :uploads
  end
end
