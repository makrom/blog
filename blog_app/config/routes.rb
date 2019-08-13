Rails.application.routes.draw do
  resources :posts
  devise_for :users
#  devise_for :users, controllers: {
#    sessions: 'users/sessions'
#  }
  get 'persons/profile', as: 'user_root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
