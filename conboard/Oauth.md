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



#### log in 할 때마다 User가 생기지 않기 위해 검증하기

1. `user.rb`

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
	...
   
   	 # User.find_auth
     def self.find_auth(auth)
        #identity가 있는지?
        identity = Identity.find_auth(auth)
        #있으면 user_id가 있기 때문에 user object가 return하고
        # 없으면 새로 만들어준다 => user는 nil
        user = identity.user
        #user가 있는지?
        if user.nil?
          user = User.new(
            email: auth.info.email,
            name: auth.info.name,
            password: Devise.friendly_token[0,20]
          )
        end
        user.save!
        if identity.user != user
            identity.user = user
            identity.save!
        end
        user #return을 user로 하기 위해
      end
    ...
        
end
```

2. `omniauth_callbacks_controller.rb`

```ruby
# app/controller/user/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]
  def facebook
    p request.env['omniauth.auth']
    auth = env['omniauth.auth']
    @user = User.find_auth(auth)

    #user가 실제 저장되었는지 체크
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      #저장이 안 된 경우 다시 로그인 하도록 하기
      redirect_to new_user_registration_path
    end
  end
end
```
> app/views/devise/shared/_links.html.erb에서
>
> `devise_mapping.omniauthable?`에서 자동으로 처리해준다


3. code 간결화

```ruby
# app/models/identity.rb
class Identity < ActiveRecord::Base
  belongs_to :user
  def self.find_auth(auth)
    find_or_create_by(
      provider: auth.provider,
      uid: auth.uid
    )
  end
end
```


#### facebook 로그인 시 프로필 사진도 가져와서 바꾸기

```bash
$ rails g migration AddProfileImgToUsers profile_img
$ rake db:migrate
```

> 만일 facebook 로그인을 이전에 했었다면 db가 변경되었기 때문에 기존 user를 지우고 다시 로그인 해야 한다.

```ruby
# app/models/user.rb
if user.nil?
    user = User.new(
        ...
        profile_img: auth.info.image #추가
        )
end
```

```erb
<!--app/views/layouts/application.html.erb 파일 수정
gravatar(current_user)가 기존에 있다면 주석 처리하기-->
<% if user_signed_in? %>
	<%= image_tag current_user.profile_img, class: "rounded-circle"%>
 	...
```

