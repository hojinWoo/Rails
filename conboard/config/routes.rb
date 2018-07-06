Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts
  post '/posts/:post_id/comments' => 'comments#create'
  get '/posts/:post_id/like' => 'likes#create'
end
