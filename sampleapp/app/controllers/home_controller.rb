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

  def google

  end

  def game

  end
  def gameresult
    # 크롤링
    require 'httparty'
    require 'nokogiri'
    url = 'https://pubg.op.gg/user/'+params[:username]
    doc = HTTParty.get(url)
    html = Nokogiri::HTML(doc.body)
    @result = html.css('#matchDetailWrap > div.user-content-layer__matches-content > div:nth-child(1) > div > div > div.user-content-layer__matches-list > ul > li:nth-child(1) > div.matches-item__summary > div.matches-item__column.matches-item__column--status > div.matches-item__reload-time')
  end

  def randomgame
  end
  def randomgameresult
    arr = ["random1.jpg","random2.jpg","random3.jpg","random4.jpg","random5.jpg"]
    @name = params[:name]
    @result = arr.sample
  end
end
