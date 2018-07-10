# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]
  def facebook
    p request.env['omniauth.auth']
    auth = env['omniauth.auth']
    @user = User.find_auth(auth, current_user)
    #<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=true expires_at=1536372854
    #token="EAAZAj7UKmP8QBAFZCxRa07nfmuLRYbRka5ymSV5MYZCxZB6NhryMDgdGpnoV3t4HjFdJXiLhtRB2qohjLgyUT4PumTA682nwD8d6mRCBrZAlMlZAnc1Go9wGXeGVn17SqoZCYdNw5ILt8WoY9qvn3Qu5JSUr9relbOsZAQlY7mDyngZDZD">
    #extra=#<OmniAuth::AuthHash raw_info=#<OmniAuth::AuthHash email="dnghwls7@gmail.com" id="2101767740103578" name="우호진">> info=#<OmniAuth::AuthHash::InfoHash
    #email="dnghwls7@gmail.com" image="http://graph.facebook.com/v2.10/2101767740103578/picture"
    #name="우호진"> provider="facebook" uid="2101767740103578">

    #user가 실제 저장되었는지 체크
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      #저장이 안 된 경우 다시 회원가입 하도록 하기
      redirect_to new_user_registration_path
    end
  end

  def kakao
    p request.env['omniauth.auth']
    auth = env['omniauth.auth']
    @user = User.find_auth(auth, current_user)
    #<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=true expires_at=1531222785
    #refresh_token="mXCegXsHgwxCIgR9mBh3EBT2rmzBYfpu9T6svQo8BRIAAAFkgrQHWQ" token="hymCBH_OMQG_WLDN7OAy3hq-ARGo7KXVD9VKjQo8BRIAAAFkgrQHXA">
    #extra=#<OmniAuth::AuthHash properties=#<OmniAuth::AuthHash nickname="우호진" profile_image="http://k.kakaocdn.net/dn/7lmgQ/btqne38zmA6/zgacNsO3et9hmygQSX0v80/profile_640x640s.jpg"
    #thumbnail_image="http://k.kakaocdn.net/dn/7lmgQ/btqne38zmA6/zgacNsO3et9hmygQSX0v80/profile_110x110c.jpg">>
    #info=#<OmniAuth::AuthHash::InfoHash image="http://k.kakaocdn.net/dn/7lmgQ/btqne38zmA6/zgacNsO3et9hmygQSX0v80/profile_110x110c.jpg" name="우호진">
    #provider="kakao" uid="810186567">

    #user가 실제 저장되었는지 체크
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      #저장이 안 된 경우 다시 회원가입 하도록 하기
      redirect_to new_user_registration_path
    end
  end

  #method 이름 변경 X
  def after_sign_in_path_for(resource)
    auth = request.env['omniauth.auth']
    @identity = Identity.find_auth(auth)
    @user = User.find(current_user.id)
    if @user.persisted?
      if auth.provider == 'kakao' && @user.email.empty?
        return users_info_path
      end
    end
    '/'
  end
end
