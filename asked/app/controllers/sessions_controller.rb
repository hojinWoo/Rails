class SessionsController < ApplicationController
  # session 관리는 user가 아닌 session controller를 추가로 만들어서 관리
  # Session CRUD만 관리
  def new
  end

  # login : session을 만드는 것
  def create
    # 1. 이메일이 가입되었는지 확인
    user = User.find_by(email: params[:email])
    # 1-1. 가입이 되었으면, 비밀번호 확인
    if user
      if user.authenticate(params[:password])
    # 1-1-1. 비밀번호가 일치하면, 로그인
        session[:user_id] = user.id
        flash[:notice] = "#{user.username}님 로그인되셨습니다."
        redirect_to '/'
    # 1-1-2. 비밀번호가 다르면, flash + :back
      else
        flash[:alert] = "비밀번호가 다릅니다."
        redirect_to :back
      end
    # 1-2. 가입이 안되었으면, flash + 가입하는 곳으로 보낼게요.
    else
      flash[:alert] = "가입되지 않은 이메일입니다."
      redirect_to '/signup'
    end
  end

  # logout : session을 지우는 것
  def destroy
    session.clear
    flash[:notice] = "로그아웃에 성공하였습니다."
    redirect_to '/'
  end
end
