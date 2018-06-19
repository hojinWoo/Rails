* # README

  `rails new board`

  

  ```bash
  # init 1 controller and 3 erb
  vagrant@ubuntu-xenial:/vagrant/board$ rails g controller post index new create
  
  # create model 
  # db/migrate/
  # 나중에 validation 할 때 사용할 파일은 추후 기록
  vagrant@ubuntu-xenial:/vagrant/board$ rails g model post
  # class post 만들기
  ```

  ```ruby
  #rake db migrate
  #DB관리
  
  # 파일 수정
  #title이라는 이름을 가진 String, body라는 이름을 가진 text 만들기     
  class CreatePosts < ActiveRecord::Migration[5.2]
    def change
      create_table :posts do |t|
        t.string :title
        t.text :body
        t.timestamps
      end
    end
  end	
          
  #db/schema.rb : 실제 db의 변경사항이 기록된다. 변경하기 위해서는 terminal에서 명령어를 입력해야 한다.
  ```

  ```bash
  # 만든 것을 실제 table로 옮겨서 set
  vagrant@ubuntu-xenial:/vagrant/board$ rake db:migrate
  
  # DB 삭제 시
  vagrant@ubuntu-xenial:/vagrant/board$ rake db:drop
  ```

  

  #### Gemfile 수정

  `group :development :test do`

  `end`

  안에!

  `gem 'rails_db'` 추가 => `$ bundle install`

  

  #### Rails DB 접속

  http://localhost:3000/rails/db

  > DB 추가 및 수정 가능 

  

  

