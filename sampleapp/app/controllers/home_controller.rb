class HomeController < ApplicationController
  ### action ###
  def lotto
    @lotto = (1..45).to_a.sample(6).sort!
  end
  # 아무것도 없어도 def 만들어야 한다.
  def index
  end

  def welcome
    @name = params[:name]
  end
end
