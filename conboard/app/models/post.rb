class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  # model validation
  #validates :title, presence: {message: "제목을 입력해주세요"}
  validates :title, presence: {message: "제목을 입력해주세요"},
                    length: {maximum: 30, too_long: "제목은 %{count}자 이내로 입력해주세요."}
  validates :content, presence: true
end
