Rails.application.routes.draw do
  root 'posts#index'

  resources :posts

  post '/posts/:post_id/comments' => 'comments#create'
end
