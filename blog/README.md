


# README

### Ruby version 낮추고 다시 수정

현재 window에서 migrate 이후 rb파일에서 column 수정 하게 될 때 migrate가 안되는 문제가 있어서 

version을 낮추게 되었다..

(만일 version을 낮추지 않고 수정 시 db/development.sqlite3 파일을 삭제 후 수정해야 한다.)

```bash
$ rbenv install 2.3.5
$ rbenv global 2.3.5
$ gem install bundler
$ gem install rails -v 4.2.10
```



- ### ORM(Object Relational Mapper)

  - rails에서는 [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html)를 활용한다.

```bash
# init
$ rails new blog
$ cd blog

# 1) create controller and model
$ rails g controller posts index new create
$ rails g model post
# app/model/post.rb
# db/migrate/201800_create_posts.rb

# db/migrate/20180619_create_posts.rb
# 2) 마이그레이션 파일 수정 후

$ rake db:migrate
#== 20180619044117 CreatePosts: migrating ======================================
#-- create_table(:posts)
#   -> 0.0131s
#== 20180619044117 CreatePosts: migrated (0.0132s) =============================
```

> db/schema.rb에 반영되었는지 확인하기.



- #### rails_db 반영하기

  - `gem 'rails_db'`
  - `$ bundle install`



### rails 서버 실행

`rails s -b 0.0.0.0`



### CRUD

action

- Create : `new`, `create`
- Read : `show`
- Update : `edit`, `update`
- Destroy : `destroy`



- #### Create

  ```bash
  irb(main):001:0 > Post.create(title: "생성", body: "생성")
  ```

- #### Read

  ```bash
  irb(main):001:0 > Post.find(id)
  ```

- #### Update

  ```bash
  irb(main):001:0 > post = Post.update.find(id)
  irb(main):002:0 > post.update(title: "변경", body: "변경")
  ```

- #### Destroy

  ```bash
  irb(main):001:0 > Post.find(id).destroy
  ```

  

  ### [Rails Flash message](http://guides.rubyonrails.org/action_controller_overview.html#the-flash)

  [alert bootstrap](https://getbootstrap.com/docs/4.1/components/alerts/)

  ```ruby
  # example
  def destroy
     flash[:alert] = "삭제되었습니다." 
  end
  ```

  ```ruby
  # app/views/layouts/_flash.html.erb 생성
  # (부분적으로 사용되는 코드인 경우 '_'를 코드 앞에 붙어셔 생성한다.)
  <% if flash[:alert] %>
    <div class="alert alert-danger" role="alert">
      <%= flash[:alert] %>
    </div>
  <% elsif flash[:notice] %>
    <div class="alert alert-info" role="alert">
      <%= flash[:notice] %>
    </div>
  <% end %>
  ```

  ### [Rails partial](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)

  `app/views/layouts/application.html.erb`

  ```bash
  <!-- <body>에 추가해서 flash 코드 적용-->
  <%= render 'layouts/flash' %>
  ```

  