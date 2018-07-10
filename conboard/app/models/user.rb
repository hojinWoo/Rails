class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :posts
  has_many :comments
  has_many :likes
  #liked_post : 좋아요를 한 게시글,
  # through : reference정보(외래키)가 like에 저장되어 있기 때문에 - 원하는 걸 찾아서 가져올 수 있도록
  has_many :liked_posts, through: :likes, source: :post

  # User.find_auth
  def self.find_auth(auth)
    #identity가 있는지?
    identity = Identity.find_or_create_by(
      provider: auth.provider,
      uid: auth.uid
    ) #있으면 user_id가 있기 때문에 user object가 return하고
    # 없으면 새로 만들어준다 => user는 nil
    user = identity.user
    #user가 있는지?
    if user.nil?
      user = User.new(
        email: auth.info.email,
        name: auth.info.name,
        password: Devise.friendly_token[0,20]
      )
    end
    user.save!
    if idntity.user != user
        identity.user = user
        identity.save!
    end
    user #return을 user로 하기 위해
  end
end
