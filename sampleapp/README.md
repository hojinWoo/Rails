# First Rails

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.4.4




## [레일스 시작하기](https://guides.rorlab.org/getting_started.html)

#### 레일스의 철학

- **같은 것을 반복하지 말 것(Don't Repeat Yourself: DRY):** DRY는 소프트웨어 개발 원칙 중의 하나이며, '시스템을 구성하는 지식의 모든 컴포넌트는 항상 하나여야 하며, 명확하고, 신뢰할 수 있는 형태로 표현하지 않으면 안된다' 라는 의미입니다. 반복적인 코드를 철저하게 피하는 것으로, 코드를 유지보수하기 쉽게하고, 간단히 확장할 수 있게 되며, 무엇보다 버그를 줄일 수 있습니다.
- **설정보다 규정을 우선한다(Convention Over Configuration):** 레일스에서는 웹 애플리케이션에서 실행될 다양한 기능들을 실현하기 위한 최선의 방법을 명확히 구상하고 있으며, 웹 애플리케이션의 각종 설정에 대해서도 기존의 경험이나 관습에 기초해, 각 설정들의 기본값을 정해두고 있습니다. 이렇듯 어떤 의미로는 독단적으로 결정된 기본값 덕분에, 개발자의 모든 의견을 반영하기 위해서 너무 자유롭게 되어있는 웹 애플리케이션처럼, 개발자가 설정파일을 설정하느라 끝없이 고생할 필요가 없습니다.



- ##### font 수정 원하는 경우..

  'firacode' , ruby에서 hash code를 많이 쓰는데 약간 귀엽게(?) 보인다.

- atom에서 markdown을 수정할 때 preview를 보고 싶은 경우

  'markdown-preview-enhanced' 설치하기



### Controller 만들기

```bash
$ cd /vagrant/sampleapp

# 'rails g controller home'
# app/controllers/에 home_controller.rb 만들어짐
# app/views에 home dir 만들어짐
$ rails generate controller home
#                           이름 action1이름 action2이름

# controller 지우기
$ 'rails d controller home'
$ rails destroy controller home
```



### Routes 및 페이지 설정

```ruby
# routes.rb
# localhost:3000/home/index 요청 시, 'home' controller의 'index' action 실행하기
get 'home/index' => 'home#index'
```

```ruby
# app/controllers/home_controller.rb
def index
end
```

```ruby
<!-- app/views/home/index.html.erb -->
안녕!
```



### Layout

```html
<!-- 모든 html.erb파일은 기본적으로
 app\views\layouts\application.html.erb의 영향을 받는다-->
<html>
    <head>
    </head>
    <body>
    	<%= yield%>
	</body>
</html>
```



### form으로 데이터 받기

1. `routes.rb`

   ```ruby
   # config/routes.rb
   get '/game' => 'home#game'
   get '/gameresult' => 'home#gameresult'
   ```

2.  `home_controller.rb`

   ```ruby
   # app/conrollers/home_controller.rb
   def game
   end
   
   def gameresult
       @username = params[:name]
   end
   ```

3.  `view` 파일 만들기

   ```erb
   <!-- app/views/home/game.html.erb -->
   <form action = "/gameresult">
       <input name = "name">
   </form>
   ```

   ```erb
   <!-- app/views/home/gameresut.html.erb -->
   <%= @username %> hello^^
   ```

   