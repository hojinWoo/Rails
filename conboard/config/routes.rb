Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts
  post '/posts/:post_id/comments' => 'comments#create'
end
