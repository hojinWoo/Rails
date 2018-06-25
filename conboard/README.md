# README.md

- #좋아요 해시태그 검색 기능
- SNS 로그인
- JS & MapAPI활용
- 채팅
- 파일 올리기
- 게시판 기능(pagination)
- 유저 기능 (관리자 등 role)
- model - validation, query

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
