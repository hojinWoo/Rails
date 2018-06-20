class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #밑에 줄을 주석처리 하면 보안 뻥뻥 뚫림(CSS attacks)
  protect_from_forgery with: :exception


end
