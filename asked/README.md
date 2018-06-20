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



#### Model을 만들고 나서 꼭

`$ rake db:migrate`