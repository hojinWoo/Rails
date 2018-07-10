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

end
