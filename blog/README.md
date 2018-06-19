


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

# 1) init
$ rails new blog
$ cd blog
$ rails g controller posts index new create
$ rails g model post

# 2) 마이그레이션 파일 수정 후
$ rake db:migrate
```

1. `gem 'rails_db'`

2. `$ bundle install`

   

### rails 서버 실행

`rails s -b 0.0.0.0`