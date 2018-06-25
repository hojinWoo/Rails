class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #밑에 줄을 주석처리 하면 보안 뻥뻥 뚫림(CSS attacks)
  protect_from_forgery with: :exception

  # VIEW에서 편하게 메소드 호출을 하려고
  helper_method :current_user
  def current_user
    # session에 저장되어있는 경우,
    # @user에 User를 찾아서 저장한다.
    # ||= 으로 저장하는 이유는, @user가 비어있는 경우에만 저장하기 위해서
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    if current_user.nil?
      flash[:alert] = "로그인을 해주세요."
      redirect_to '/'
    end
  end
end
