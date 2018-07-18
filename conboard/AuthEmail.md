# 이메일 인증

- AWS를 이용하여 회원가입 시 이메일이 실제 존재하는 지 체크



### [SMTP 프로토콜 사용](https://ko.wikipedia.org/wiki/%EA%B0%84%EC%9D%B4_%EC%9A%B0%ED%8E%B8_%EC%A0%84%EC%86%A1_%ED%94%84%EB%A1%9C%ED%86%A0%EC%BD%9C)

- AWS에서 SES(Simple Email Service) 사용		(cf. 지역은 3개만 있음)
  [Email addresses] - [verify a new email address] 보낼 이메일 등록(인증)하기
  이메일 인증 후에 V
  (나중에 상용 시 실제 서비스할 이메일로 등록하면 된다.)

- [SMTP Settings] - [Create My SMTP Credentials] 해서 SMTP 사용자 만들기
  ![confirm email](./app/assets/mages/verify.png)

  **SMTP 사용자 이름과 비밀번호는 개인이 가지고 있어야 한다.**

  ```ruby
  # config/application.yml에 넣어서 증명하기(파일이 없다면 figrao 설치하기)
  # [SMTP Settings] - [Create My SMTP Credentials]에서 server Name가져오기
  SES_ADDRESS: YOUR_SERVER_NAME
  
  SES_USER_NAME: YOUR_SMTP_NAME
  SES_PASSWORD: YOUR_SMTP_PASSWORD
  ```

  

- ##### Devise 정보 추가

  ```ruby
  # config/initializers/devise.rb
  config.mailer_sender = 'YOUR_RECIVE_EMAIL' # 21 line 이메일 수정(AWS에 증명 메일과 같은 메일로)
  
  config.reconfirmable = false #145 line 수정 (true로 되어 있어도 지금은 큰 상관 없음)
  ```

- ##### mail 이 잘못 간 경우 알기 위해 설정

  ```ruby
  # config/environments/development.rb
  config.action_mailer.default_url_options = {host: 'http://localhost', port: 3000}
    config.action_mailer.smtp_settings = {
      address: ENV["SES_ADDRESS"],
      user_name: ENV["SES_USER_NAME"],
      password: ENV["SES_PASSWORD"],
      port: 587,
      authentication: :login
    }
  config.action_mailer.raise_delivery_errors = true # 17 line false > true로 수정
  ```

- 계정 확인

  ```ruby
  # app/models/user.rb
  # 계정도 한 개만 만들 수 있도록 설정
  devise :confirmable 추가
  ```

- #### [confirmable to Users](https://github.com/plataformatec/devise/wiki/How-To:-Add-:confirmable-to-Users)

  이메일 보낸 날짜, 토큰 등을 저장하기 위해 migration 추가

  ##### New Migration

  `$ rails g migration add_confirmable_to_devise`

  ```ruby
  # db/migrate/..._add_confirmable_to_devise.rb
  def change
      # 붙여넣기
      add_column :users, :confirmation_token, :string
      add_column :users, :confirmed_at, :datetime
      add_column :users, :confirmation_sent_at, :datetime
      # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
      add_index :users, :confirmation_token, unique: true
      # User.reset_column_information # Need for some types of updates, but not for update_all.
      # To avoid a short time window between running the migration and updating all existing
      # users as confirmed, do the following
      
      #User.all.update_all confirmed_at: DateTime.now #기존의 저장되어 있는 사람들도 확인하기
  end
  ```

  > `$ rake db:migrate`

  - 만약 `$ rake db:drop`이 되고 migrate가 익숙하지 않다면!!

    ```ruby
    # db/migrate/..._devise_create_user.rb
    ## Confirmable 주석 해제하고
    t.string   :confirmation_token
    t.datetime :confirmed_at
    t.datetime :confirmation_sent_at
    t.string   :unconfirmed_email
    ```

    > $ rake db:migrate



- 회원 가입 시 인증 메일이 날아온다(도메인을 입력 안한 경우 메일이 스팸 메일에 있을 것)
  ![confirm email](./app/assets/mages/email.png)

  ```erb
  <!-- views/users/mailer/confirmation_instructions.html.erb --> 
  <!-- 여기서 확인 이메일의 문구 등을 수정할 수 있다. --> 
  ```

  **비밀번호를 잊어버렸을 때에도 메일이 와서 바꿀 수 있다.**