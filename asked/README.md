# Asked 

`$ rails new asked`

##### 서버 시작 : `$ rails s -b 0.0.0.0`



- posts Controller 
  `$ rails g controller posts index new create show edit update destroy ` 

  - index
  - Create  : `new` `create`
  - Read     : `show`
  - Update : `edit` `update`
  - Delete   : `destroy`

- post Model

  `$ rails g model post username:string title:string content:text`

  - string `username`
  - string `title`
  - text    `content`

- user Model
  `$ rails g model user username:string email:string password:string`

  - string `username`
  - string `email`
  -  string `password`

- user Controller

  `$ rails g controller users index create login new posts`

#### Model을 만들고 나서 꼭

`$ rake db:migrate`



----------

독립된 것은 controller로 구분 (session 만들고 삭제 관리)

`$ rails g controller sessions`



### [Rails 기본 라우팅](http://guides.rubyonrails.org/routing.html#resource-routing-the-rails-default)

```ruby
## config/routes.rb ##
# index
get `posts` => 'posts#index'
# CRUD - C
get 'posts/new'
post 'posts' #게시글 등록
# CRUD - R
get 'posts/:id' => 'posts#show'
# CRUD - U
get 'posts/:id/edit' => 'posts#edit'
put 'posts/:id' => 'posts#update'
# CRUD - D
delete 'posts/:id' => 'posts#destroy'

#cf. put, delete는 html5.0부터 <form>tag에서 지원 X
```

```ruby
resources :posts
#처음에 만든 위에 Post의 CRUD는 한 줄로 대체가능
```

> REST API 구성의 기본 원칙 2가지
>
> 1. URI는 정보의 자원을 표현해야 한다
> 2. 자원에 대한 행위는 HTTP method(verb)로 표현한다.



#### Form에서 post 요청 보내기

```erb
<!-- app/views/posts/new.html.erb -->
<form action="/posts" method = "post">
    ...
    <!-- post 요청 -->
    <input type="hidden" name = "authenticity_token" value = "<%= form_authenticity_token %>">
    ...
</form>
```

```ruby
# token이 없는 경우 error 발생 (token은 CSRF 공격 방지하기 위해서 사용)
# app/controllers/application_controller.rb
protect_from_forgery with: :exception
```



#### Form에서 put 요청 보내기

```erb
<!-- app/views/posts/new.html.erb -->
<form action="/posts" method = "post">
    ...
    <!-- post 요청 -->
    <input type="hidden" name = "authenticity_token" value = "<%= form_authenticity_token %>">
    
    <!-- put 요청 -->
    <input type = "hidden" name = "_method" value = "put">
    ...
</form>
```

```erb
<a href="/posts/<%= @post.id%>" data-method="delete" data-confirm="are you sure?">게시글 삭제</a>
```



##### [CodePen](https://codepen.io/) 활용해서 CSS 디자인 활용 가능



### Database relation(association)

- 1:N (1:多)
  User(1) - Posts(N) 관계
  cf. N에 해당하는 애들이 foriegn key를 가지고 있어야 편하다

- 실제 코드 적용

  1. 객체 관례 설정

  ```ruby
  #app/model/user.rb
  class User < ActiveRecord::Base
      has_many :posts
  end
  ```

  ```ruby
  #app/model/posts.rb
  class Post < ActiveRecord::Base
    	belongs_to :user  
  end
  ```

- 2. DB 관계 설정

  ```ruby
  #db/migrate/20180625_create_posts.rb
  ...
  	t.integer :user_id #foriegn key
  	t.string :title
  	t.text :content
  ...
  ```

  > $ rake db:migrate
  >
  > > 기존에 db가 있었다면 db를 다 지우고 다시 만들어야 한다
  > >
  > > $ rake db:drop

  

- 실제로 관계 활용하기

  1. 유저가 가지고 있는 모든 게시물

     ```ruby
     # 1번 유저의 모든 글
     @user_posts = User.find(1).posts
     # 글의 갯수
     User.find(1).posts.count
     ```

  2.  특정 게시글에서 작성한 사람 정보 출력

     ```ruby
     # 1번 글의 작성자 이름
     Post.find(1).user.username
     ```

     





