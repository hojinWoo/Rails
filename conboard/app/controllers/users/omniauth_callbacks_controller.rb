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
end
