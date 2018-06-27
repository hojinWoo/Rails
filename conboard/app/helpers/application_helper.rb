module ApplicationHelper
  # 중복된 코드를 줄일 수 있다.
  def flash_message(type)
    case type
      when "alert" then "alert alert-warning"
      when "notice" then "alert alert-primary"
    end
  end

  def gravatar(user)
    if user
      email = Digest::MD5.hexdigest(user.email)
      #암호화 (MD5 : 이미 다 뚫림..) 된 url 및 size 크기 설정
      # default image: mystery people
      url = "https://s.gravatar.com/avatar/#{email}?s=80&d=mp"
      # possible retun tag
      image_tag(url, alt: user.name, class: "rounded-circle")
    end
  end
end
