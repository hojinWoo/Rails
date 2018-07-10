# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]
  def facebook
    p request.env['omniauth.auth']
    auth = env['omniauth.auth']
    @user = User.find_auth(auth)

    #user가 실제 저장되었는지 체크
    if @user.persisted?
      redirect_to '/'
    else
      #저장이 안 된 경우 다시 회원가입 하도록 하기
      redirect_to new_user_registration_path
    end
  end
end
