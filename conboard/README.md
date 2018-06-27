# README.md

##### Version

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

-----

### Initial

```bash
# scaffold : 구조물
$ rails new scaffold_test

$ cd scaffold_test

$ rails g scaffold post title:string content:text

$ rake db:migrate

$ rails s -b 0.0.0.0
```

> 기존 rails 와 다른 것
>
> > controller
>
> > view
>
> > routes

| Helper         | HTTP Verb | Path                      | Controller#Action |
| -------------- | --------- | ------------------------- | ----------------- |
| posts_path     | GET       | /posts(.:format)          | posts#index       |
|                | POST      | /posts(.:format)          | posts#create      |
| post_path      | GET       | /posts/:id(.:format)      | posts#show        |
|                | PATCH     | /posts/:id(.:format)      | posts#update      |
|                | PUT       | /posts/:id(.:format)      | posts#update      |
|                | DELETE    | /posts/:id(.:format)      | posts#destro      |
| new_post_path  | GET       | /posts/new(.:format)      | posts#new         |
| edit_post_path | GET       | /posts/:id/edit(.:format) | posts#edit        |

>  `<a>` tag로는 Get 요청, `<form>` tag로 Post 요청만 보낼 수 있다.

### link_to : url helper(http://api.rubyonrails.org/v5.2/classes/ActionView/Helpers/UrlHelper.html)

```erb
<%= link_to '글 보기', @post %>
<%= link_to '글 보기', post_path, class: "btn btn-warning" %>
<%= link_to '새 글 쓰기', new_post_path %>
<%= link_to '글 수정', edit_post_path %>
<%= link_to '모든 글 보기', posts_path %>
<%= link_to '글 삭제', post_path, method: :delete, data: {confirm: "지울래?"} %>
```



### [Form_tag, Form_for](http://guides.rubyonrails.org/form_helpers.html)

- [form for](http://guides.rubyonrails.org/form_helpers.html#binding-a-form-to-an-object)을 쓸 때 더 유용
  -  form_for method로부터 form buidler 객체를 만들어준다.
- post, put 사용시 기본으로 token을 만들어준다.

```erb
<form action="/posts" method="post">
  <input type="text" name="title" /> <br />
  <textarea name="content"></textarea> <br />
  <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token%>">
  <input type="submit" />
</form>
```

```erb
<%= form_tag('/posts', method: 'post') do %>
  <%= text_field_tag :title %>
  <%= text_area_tag :content %>
  <%= submit_tag "뿅!"%>
<% end %>
```

```erb
<!-- edit.html.erb, new.html.erb 중복 코드-->
<%= form_for @post do |f| %>
  <%= f.text_field :title %>
  <%= f.text_area :content %>
  <%= f.submit %>
<% end %>
```

- `form_for` 주요 특징
  - 특정한 model의 객체를(Post) 조작하기 위해 사용
  - 별도의 URL(action = "/"), method(get, post, put) 등을 명시하지 않아도 된다.
  - Controller의 해당 Action(`new`, `edit`) 에서 반드시 @post에 Post Object가 있어야 한다.
    - `new`   : `@post = Post.new`
    - `edit` : `@post = Post.find(id)`
  - 각 input field의 symbol은 반드시 @post의 column명과 일치해야 한다.



### [gem : simple form](https://github.com/plataformatec/simple_form)

1. Gemfile 설정

   ```ruby
   gem 'simple_form'
   ```

2. `bundle install`

   ```bash
   $ bundle install
   ```

3. 설치

   ```bash
   $ rails generate simple_form:install --bootstrap
   ```

4. Bootstrap 프로젝트 적용

   - CDN을 `applicataion.html.erb`

5. Form helper 만들기

   ```erb
   <%= simple_form_for @post do |f| %>
   	<%= f.input :title %>
   	<%= f.input :content %>
   	<%= f.button :submit, class: "btn-primary" %>
   <% end %>
   ```



------



### Model validation

```ruby
# app/model/post.rb
...
  validates :title, presence: {message: "제목을 입력해주세요."},
                    length: {maximum: 30,
                            too_long: "제목은 %{count}자 이내로 입력해주세요." }
  validates :content, presence: {message: "내용을 입력해주세요."}
...
```

```ruby
def create
    @post = Post.new(post_params)
    respond_to do |format|
        if @post.save
            format.html {redirect_to '/', notice: } #notice는 flash[:notice]에 값을 담기 위해서
        else
            format.html {render :new}
            format.json {render json: @post.errors}
        end
    end
end
```

```erb
<!--app/views/posts/_form.html.erb -->
..
	<%= f.error_notification %>
..
```



### Helper

코드의 양을 줄일 수 있다.

```ruby
# app/helpers/application_helper.rb
def flash_message(type)
    case type
		when "alert" then "alert alert-warning"
		when "notice" then "alert alert-primary"
	end
end
```

```erb
<!-- app/views/layouts/application.html.erb -->
<% flash.each do |key, value| %>
	<!--role은 없어도 무방 -->
	<div class = "<%= flash_message(key) %>" role="alert">
		<%= value %>
    </div>
<% end %>
```



### [Kaminary](https://github.com/kaminari/kaminari)

1. gemfile

   ```ruby
   gem 'kaminari'
   ```

   > $ bundle install

2. controller 설정

   ```ruby
   # app/controllers/posts_controller.rb
   def index
       # use kaminari - 1page에 5개의 글만 보일 수 있도록 설정
   	@posts = Post.all.page(1).per(5)
   
   	# 게시판 번호 이동을 하기 위해서 이동된 page 번호를 받아오기.
   	@posts = Post.all.page(params[:page]).per(5)
   end
   ```

3. view 설정

   ```erb
   <!-- 게시판의 번호 이동을 표현해준다 -->
   <div class="d-flex justify-content-center">
     <%= paginate @posts %>
   </div>
   ```

4. theme 설정

   bootstrap 적용하려면 따로 [kaminari view](https://github.com/amatsuda/kaminari_themes) 를 설정하면 된다

   예시)

   ```bash
   $ rails g kaminari:views bootstrap4
   ```

   

### 권한 부여

삭제 및 수정을 권한 주기(직접 코드로 할 수 있지만 controller가 무거워지므로 gem을 이용하기로 함)

#### [cancancan](https://github.com/CanCanCommunity/cancancan)

```ruby
# install
# rails version이 4.2 이상이므로
gem 'cancancan', '~> 2.0'
```

1. Abilities 정의하기

   ```bash
   $ rails g cancan:ability
   ```

2. check ability

   ```ruby
   # app/models/ability.rb
   # login 안 되어 있을 때 권한
   can :read, Post
   return unless user.present?
   # login 후 edit, delete 등 사용자가 같을 때 가능
   can :manage, Post, user_id: user_id
   can :create, Comment
   ```

3. Controller helpers

   ```ruby
   # app/controllers/post_controller.rb
   # 이 코드는 restful하기 때문에 Loaders 사용. 아닌 경우 각각 지정 필요.
   load_and_authorize_resource
   ```

4. Handle Unauthorized access

   ```ruby
   # app/controllers/application_controller.rb
   # 일치하지 않을 때 handling하기
   ..
       rescue_from CanCan::AccessDenied do |exception|
           respond_to do |format|
               format.json { head :forbidden, content_type: 'text/html' }
               format.html { redirect_to main_app.root_url, notice: exception.message }
               format.js   { head :forbidden, content_type: 'text/html' }
           end
       end
   ..
   ```

   

-----

##### 앞으로 할 일 들

- #좋아요 해시태그 검색 기능
- SNS 로그인
- JS & MapAPI활용
- 채팅
- 파일 올리기
- 게시판 기능(pagination)
- 유저 기능 (관리자 등 role)
- model - validation, query

