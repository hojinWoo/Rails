class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  # model validation
  validates :title, presence: {message: "제목을 입력해주세요"}
  validates :content, presence: true
end
