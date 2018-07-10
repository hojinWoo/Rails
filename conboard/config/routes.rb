Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    match 'users/info' => 'users/registrations#info', via: [:get, :patch]
  end
  root 'posts#index'
  resources :posts
  post '/posts/:post_id/comments' => 'comments#create'
  # get '/posts/:post_id/likeA' => 'likes#like'
  put '/posts/:post_id/like' => 'likes#create'
  delete '/posts/:post_id/like' => 'likes#destroy'

  post '/tinymce_assets' => 'tinymce_assets#create'
end
