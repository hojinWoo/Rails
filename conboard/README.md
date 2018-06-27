# README.md

- #좋아요 해시태그 검색 기능
- SNS 로그인
- JS & MapAPI활용
- 채팅
- 파일 올리기
- 게시판 기능(pagination)
- 유저 기능 (관리자 등 role)
- model - validation, query



### Version

- ruby : 2.3.5
- rails : 4.2.10



#### cf) 다른 곳에서 git clone 하고 git push 할 때 주의사항

```bash
# git remote : 현재 git에 등록되어 있는 것 확인
$ git remote
origin

# 삭제하기
$ git remote remove origin
```



### Post

- posts Controller 
  `$ rails g controller posts index new create show edit update destroy`
- post Model
  `$ rails g model post title:string content:text`



### Comment(N)

- comments Controller
  - CRUD - C
    `$ rails g controller comments`
- comment Model
  - `$ rails g model comment content:string post_id:integer` 



## [회원가입 Gem(devise)으로 관리하기](https://github.com/plataformatec/devise#getting-started)

1. `devise` gem 설치

   ```ruby
   # Gemfile
   gem 'devise'
   ```

   ```bash
   $ bundle install
   ```

2. devise 설치

   ```bash
   $ rails generate devise:install
   ```

   > `config/initialize/devise.rb` 만들어짐.

3. user 모델 만들기

   ```bash
   $ rails generate devise User 
   ```

   > db/migrate/20180625_devise_create_users.rb
   >
   > model/user.rb
   >
   > config/routes.rb :: devise_for :users
   >
   > >  cf. 지울 때는 rails d model user

4. migration

   ```bash
   $ rake db:migrate
   ```

5. routes 확인

| new_user_session_path         | GET    | /users/sign_in(.:format)       | devise/sessions#new         |
| ----------------------------- | ------ | ------------------------------ | --------------------------- |
| user_session_path             | POST   | /users/sign_in(.:format)       | devise/sessions#create      |
| destroy_user_session_path     | DELETE | /users/sign_out(.:format)      | devise/sessions#destroy     |
| user_password_path            | POST   | /users/password(.:format)      | devise/passwords#create     |
| new_user_password_path        | GET    | /users/password/new(.:format)  | devise/passwords#new        |
| edit_user_password_path       | GET    | /users/password/edit(.:format) | devise/passwords#edit       |
|                               | PATCH  | /users/password(.:format)      | devise/passwords#update     |
|                               | PUT    | /users/password(.:format)      | devise/passwords#update     |
| cancel_user_registration_path | GET    | /users/cancel(.:format)        | devise/registrations#cancel |
| user_registration_path        | POST   | /users(.:format)               | devise/registrations#create |
| new_user_registration_path    | GET    | /users/sign_up(.:format)       | devise/registrations#new    |
| edit_user_registration_path   | GET    | /users/edit(.:format)          | devise/registrations#edit   |
|                               | PATCH  | /users(.:format)               | devise/registrations#update |
|                               | PUT    | /users(.:format)               | devise/registrations#update |
|                               | DELETE | /users(.:format)               |                             |

> 회원가입 : `get 'users/sign_up'`
>
> 로그인 : `get 'users/sign_in'`
>
> 로그아웃 : `delete 'users/sign_out'`

6. helper method

- `user_sign_in?` : 유저가 로그인 했는지 안했는지를 true/false 리턴

- `current_user` : 로그인되어있는 user 오브젝트를 가지고 있음

- `before_action :authenticate_user!`

  : 로그인 되어있는 유저 검증(필터)

7. View 파일 수정하기

   ```bash
   # user의 View 만들기
   # app/views/users
   $ rails generate devise:views users
   ```

8. config 수정

   ```ruby
   # config/initializers/devise.rb
   config.scoped_views = true #232 line 주석 해제하고 수정하기
   ```

   > 모든 initailizers 폴더 안에 있는 설정은 서버 재부팅 필요

9. [custom column 추가하기](https://github.com/plataformatec/devise#strong-parameters) 

   1. migration 파일에 원하는 column 

   2. `app/views/devise/registrations/new.html.erb` input 추가

   3. `app/controllers/application_controller.rb`

   ```ruby
   before_action :configure_permitted_parameters, if: :devise_controller?
   
   protected
   
   def configure_permitted_parameters
   	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
   end
   ```



----------

### seeds.rb

```ruby
# db/seeds.rb
# db를 만들 때 주로 사용 (ex. csv)
# 수정 후 command에서 $ rake db:seed 입력 하면 적용
```



### Dummy data 만들기

[gem faker](https://github.com/stympy/faker)

```ruby
gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
```

```ruby
# db/seeds.rb
# make dummy data
require 'faker'
10.times do
  Post.create(
    title: Faker::OnePiece.unique.character,
    content: Faker::OnePiece.quote
  )
end
```



#### [Active Record query interface](http://guides.rubyonrails.org/active_record_querying.html#array-conditions)

`pry-rails`로 console에서 사용했다.

```ruby
# title column data 기준으로 order하기
Post.order(:title)
Post.order(:title: :desc) #내림차순
Post.order(:title: :asc)  #오름차순

# column 중 제목이 aa인 게시글의 정보 표출
Post.where("title = ?", "aa")

# aa가 들어있는 모든 게시글 표출
Post.where("title like ?", "%aa%")

# 처음부터 3개 가져오기
Post.first(3)
# 뒤에서부터 3개 가져오기
Post.last(3)
```

```ruby
# root page로 갈 때 기록되는 것들을 볼 수 있다.
> app.get('/')

# 응답에 대한 data
> r = app.response
> cd r
# .methods처럼 할 수 있는 것들을 볼 수 있다.
> ls

> r.cookies #cookie
> r.header #http 요청 시 header

# 로그인 요청
> app.post('/users/sign_in',email: "11@11", password: '123456')
> app.session[:session_id]

> app.controller.params # 넘어오는 것들 및 경로를 볼 수 있다.

# 10번 글 요청
app.get('/posts/10') # 로그인이 안 되어 있는 경우 302 error

> app.flash # 경고문을 볼 수 있다.
```



### [Form helper](http://guides.rubyonrails.org/form_helpers.html)

- [form for](http://guides.rubyonrails.org/form_helpers.html#binding-a-form-to-an-object)을 쓸 때 더 유용
  -  form_for method로부터 form buidler 객체를 만들어준다.
- post, put 사용시 기본으로 token을 만들어준다.



### [Simple Form](https://github.com/plataformatec/simple_form)

- `gem 'simple_form'`

- bootstrap 적용 할 때 사용.

- cf) `'rails_db'`에도 같이 들어 옴.

  ```bash
  # for Bootstrap
  $ rails generate simple_form:install --bootstrap
  ```

  