# Oauth

token으로 인증절차가 이루어진다.



### [omniauth-facebook](https://github.com/mkdynamic/omniauth-facebook)

```ruby
# GEMFILE
gem 'omniauth-facebook'
```

> bundle install

```ruby
# app/models/user.rb line 추가
devise ...
	  :omniauthable, omniauth_providers: [:facebook]
```

```bash
# app/controller/user 폴더가 없으면 입력하기
$ rails g devise:controllers users
```

```ruby
# app/routes.rb 수정
devise_for :users, controllers: {
	sessions: 'users/sessions',
	omniauth_callbacks: 'users/omniauth_callbacks'
}
```

```ruby
# config/initializers/devise.rb 260 line 추가
...
	config.omniauth :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET']
...
```



```bash
# 로그인은 카카오 페이스북 등 1:N 관계이기 때문에 인증 관계 table을 만든다
$ rails g model identity user:references provider uid
$ rake db:migrate
```

